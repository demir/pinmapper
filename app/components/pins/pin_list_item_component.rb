# frozen_string_literal: true

module Pins
  class PinListItemComponent < ViewComponent::Base
    with_collection_parameter :pin

    def initialize(pin:)
      @pin = pin
    end
  end
end
