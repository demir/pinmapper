# frozen_string_literal: true

module Pins
  class MoreButtonComponent < ViewComponent::Base
    def initialize(pin:, current_user: nil)
      @pin = pin
      @current_user = current_user
    end

    def render?
      @current_user.present?
    end
  end
end
