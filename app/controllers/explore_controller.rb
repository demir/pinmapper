# frozen_string_literal: true

class ExploreController < ApplicationController
  include Pagy::Backend
  before_action :set_pin, only: %i[location]

  def index
    @pagy, @pins = pagy_pins_latest items: 10
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  def location
    @pagy, @pins = pagy_nearby_pins @pin, items: 10
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  private

  def set_pin
    @pin = Pin.find_by(token: params[:token])
  end

  def pagy_pins_latest(vars = {})
    pagy = Pagy::Countless.new(page: params[:page], countless_minimal: true, **vars)
    [pagy, Pins::Latest.call(user: nil, pagy:)]
  end

  def pagy_nearby_pins(pin, vars = {})
    pagy = Pagy::Countless.new(page: params[:page], countless_minimal: true, **vars)
    [pagy, Pins::Latest.nearby_pins(pin, pagy)]
  end
end
