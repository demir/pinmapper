# frozen_string_literal: true

class Pins::FormComponent < ViewComponent::Base
  def initialize(pin:)
    @pin = pin
  end
end
