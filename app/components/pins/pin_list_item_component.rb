# frozen_string_literal: true

class Pins::PinListItemComponent < ViewComponent::Base
  with_collection_parameter :pin

  def initialize(pin:)
    @pin = pin
  end
end
