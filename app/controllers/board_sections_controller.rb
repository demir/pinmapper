# frozen_string_literal: true

class BoardSectionsController < ApplicationController
  before_action :set_board_section, only: %i[show edit update destroy move move_pin
                                             add_pin remove_pin select_board_sections
                                             autocomplete merge]
  before_action :set_board
  before_action :set_pin, only: %i[add_pin remove_pin]
  before_action :authorize_board_section

  # GET /board_sections/1 or /board_sections/1.json
  def show; end

  # GET /board_sections/new
  def new
    @board_section = BoardSection.new
  end

  # GET /board_sections/1/edit
  def edit; end

  # POST /board_sections or /board_sections.json
  # rubocop:disable Metrics/MethodLength
  def create
    @board_section = BoardSection.new(board_section_params)
    @board_section.board = @board

    respond_to do |format|
      if @board_section.save
        format.html { redirect_to board_url(@board), notice: t('.success') }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board_section.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  # PATCH/PUT /board_sections/1 or /board_sections/1.json
  def update
    respond_to do |format|
      if @board_section.update(board_section_params)
        format.html { redirect_to board_url(@board), notice: t('.success') }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /board_sections/1 or /board_sections/1.json
  def destroy
    @board_section.destroy

    respond_to do |format|
      format.html { redirect_to board_url(@board), notice: t('.success') }
      format.json { head :no_content }
      flash.now[:notice] = t('.success')
      format.turbo_stream
    end
  end

  def move
    @board_section.insert_at(params[:position].to_i)
    head :ok
  end

  def move_pin
    @board_section.pin_board_sections.find_by(pin: params[:pin_id]).insert_at(params[:position].to_i)
    head :ok
  end

  def add_pin
    @board_section.pins << @pin
  end

  def remove_pin
    @board_section.pins.delete(@pin)
  end

  def select_board_sections; end

  def autocomplete
    list = @board.board_sections.where.not(id: @board_section)
    list = list.trigram_search_by_name(params[:q]) if params[:q].present?

    render(json: list.map { |u| { text: u.name, value: u.id } })
  end

  # rubocop:disable Metrics/AbcSize
  def merge
    other_board_section = BoardSection.find(params[:other_board_section_id])
    other_board_section.pins << @board_section.pins.where.not(id: other_board_section.pins)
    @board_section.destroy

    respond_to do |format|
      format.html { redirect_to board_url(@board), notice: t('.success') }
      format.json { head :no_content }
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board_section
    @board_section = BoardSection.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def board_section_params
    params.require(:board_section).permit(:name, :description)
  end

  def set_board
    @board = @board_section&.board.presence || Board.friendly.find(params[:board_id])
  end

  def set_pin
    return if params[:pin_id].blank?

    @pin = Pin.friendly.find(params[:pin_id])
  end

  def authorize_board_section
    authorize @board_section || BoardSection.new
  end
end
