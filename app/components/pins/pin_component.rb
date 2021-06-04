# frozen_string_literal: true

module Pins
  class PinComponent < ViewComponent::Base
    def initialize(pin:, current_user: nil)
      @pin = pin
      @current_user = current_user
    end
  end
end
