# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class BoardsController < ApplicationController
  include Pagy::Backend
  before_action :set_board, only: %i[show edit update destroy
                                     add_pin remove_pin follow unfollow move
                                     move_board_by_id add_to_board_section_list
                                     select_boards autocomplete merge]
  before_action :set_pin, only: %i[add_pin remove_pin add_to_board_list new create]
  before_action :authorize_board

  # GET /boards or /boards.json
  def index
    @pagy, @boards = pagy current_user.boards
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  def add_to_board_list
    boards = get_boards(@pin)
    %i[name].each do |param|
      boards = search(boards, param, params[param]) if params[param].present?
    end
    @pagy, @boards = pagy(boards)
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  def add_to_board_section_list
    @pin = Pin.find(params['pin_id'])
    board_sections = @board.board_sections
    %i[name].each do |param|
      board_sections = search_board_section(board_sections, param, params[param]) if params[param].present?
    end
    @pagy, @board_sections = pagy(board_sections)
    respond_to do |f|
      f.turbo_stream
    end
  end

  # GET /boards/1 or /boards/1.json
  def show
    map_pin_ids = @board.pins.ids |
                  Pin.joins(board_sections: :board)
                     .where(board_sections: { boards: { id: @board } }).ids
    @map_pins = Pin.where(id: map_pin_ids)
    @pagy, @pins = pagy @board.pins
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit; end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  # POST /boards or /boards.json
  def create
    @board = current_user.boards.build(board_params)
    respond_to do |format|
      if @board.save
        format.html { redirect_to boards_url, notice: t('.success') }
        format.json { render :show, status: :created, location: @board }
        flash.now[:notice] = t('.success')
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
      format.turbo_stream
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to boards_url, notice: t('.success') }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url, notice: t('.success') }
      format.json { head :no_content }
      flash.now[:notice] = t('.success')
      format.turbo_stream
    end
  end

  def add_pin
    @board.pins << @pin
  end

  def remove_pin
    @board.pins.delete(@pin)
  end

  def follow
    current_user.following_boards << @board
    respond_to do |format|
      format.turbo_stream
    end
  end

  def unfollow
    current_user.following_boards.delete(@board)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def following_boards
    @pagy, @boards = pagy current_user.following_boards.order(created_at: :desc)
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  def move
    @board.pin_boards.find_by(pin: params[:pin_id]).insert_at(params[:position].to_i)
    head :ok
  end

  def move_board_by_id
    @board.insert_at(params[:position].to_i)
  end

  def select_boards; end

  def autocomplete
    list = current_user.boards.where.not(id: @board)
    list = list.trigram_search_by_name(params[:q]) if params[:q].present?

    render(json: list.map { |u| { text: u.name, value: u.id } })
  end

  def merge
    other_board = Board.find(params[:other_board_id])
    board_service = BoardServices::Merge.call(from: @board, to: other_board)
    flash_message = board_service[:success] ? { notice: t('.success') } : { alert: t('.failure') }

    respond_to do |format|
      format.html { redirect_to boards_path, flash_message }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.friendly.find(params[:id])
  end

  def set_pin
    return if params[:pin_id].blank?

    @pin = Pin.friendly.find(params[:pin_id])
  end

  # Only allow a list of trusted parameters through.
  def board_params
    params.require(:board).permit(:name, :description, :privacy)
  end

  def authorize_board
    authorize @board || Board
  end

  def search(boards, attr, attr_value)
    boards.send("trigram_search_by_#{attr}", attr_value)
  end

  def search_board_section(board_sections, attr, attr_value)
    board_sections.send("trigram_search_by_#{attr}", attr_value)
  end

  def get_boards(pin)
    added_boards = current_user.boards.left_joins(:pins).where(pins: { id: pin })
                               .order('boards.created_at DESC')
    not_added_boards = current_user.boards.where.not(id: added_boards).order(created_at: :desc)
    Board.find_ordered(added_boards.ids | not_added_boards.ids)
  end
end
# rubocop:enable Metrics/ClassLength
