# frozen_string_literal: true

class ExploreController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @pins = pagy_pins_latest Pin, items: 10
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  private

  def pagy_pins_latest(collection, vars = {})
    pagy = Pagy.new(count: collection.count(:all), page: params[:page], **vars)
    [pagy, Pins::Latest.call(user: nil, pagy: pagy)]
  end
end
