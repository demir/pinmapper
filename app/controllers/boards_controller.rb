# frozen_string_literal: true

class BoardsController < ApplicationController
  include Pagy::Backend
  before_action :set_board, only: %i[show edit update destroy
                                     add_pin remove_pin follow unfollow]
  before_action :set_pin, only: %i[add_pin remove_pin add_to_board_list]
  before_action :authorize_board

  # GET /boards or /boards.json
  def index
    @pagy, @boards = pagy current_user.boards.order(created_at: :desc)
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

  # GET /boards/1 or /boards/1.json
  def show
    @pagy, @pins = pagy @board.pins.order(created_at: :desc)
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

  # rubocop:disable Metrics/AbcSize
  # POST /boards or /boards.json
  def create
    @board = current_user.boards.build(board_params)
    respond_to do |format|
      if @board.save
        format.html { redirect_to boards_url, notice: t('.success') }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  def set_pin
    @pin = Pin.friendly.find(params[:pin_id])
  end

  # Only allow a list of trusted parameters through.
  def board_params
    params.require(:board).permit(:name, :privacy)
  end

  def authorize_board
    authorize @board || Board
  end

  def search(boards, attr, attr_value)
    boards.send("trigram_search_by_#{attr}", attr_value)
  end

  def get_boards(pin)
    added_boards = current_user.boards.left_joins(:pins)
                               .where(pins: { id: pin })
                               .order('boards.created_at DESC')
    not_added_boards = current_user.boards.where.not(id: added_boards).order(created_at: :desc)
    Board.find_ordered(added_boards.ids | not_added_boards.ids)
  end
end
