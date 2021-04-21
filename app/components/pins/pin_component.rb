# frozen_string_literal: true

class Pins::PinComponent < ViewComponent::Base
  def initialize(pin:)
    @pin = pin
  end
end
