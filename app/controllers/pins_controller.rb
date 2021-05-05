class PinsController < ApplicationController
  before_action :set_pin, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /pins or /pins.json
  def index
    @pins = Pin.order(created_at: :desc)
  end

  # GET /pins/1 or /pins/1.json
  def show; end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit; end

  # POST /pins or /pins.json
  def create
    @pin = current_user.pins.build(pin_params)
    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: t('.success') }
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1 or /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin, notice: t('.success') }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1 or /pins/1.json
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pin
    @pin = Pin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pin_params
    params.require(:pin).permit(:name, :address, :latitude, :longitude, :category, :privacy,
                                :cover_image_description, :cover_image, :description,
                                cover_image_crop_attributes: %i[crop_x crop_y crop_width crop_height])
  end
end
