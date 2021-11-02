# frozen_string_literal: true

module Pins
  class SmallPinComponent < ViewComponent::Base
    with_collection_parameter :pin
    attr_reader :pin, :current_user

    def initialize(pin:, current_user:)
      @pin = pin
      @current_user = current_user
    end
  end
end
