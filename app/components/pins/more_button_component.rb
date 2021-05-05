# frozen_string_literal: true

class Pins::MoreButtonComponent < ViewComponent::Base
  def initialize(pin:)
    @pin = pin
  end
end
