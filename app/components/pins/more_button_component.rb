# frozen_string_literal: true

module Pins
  class MoreButtonComponent < ViewComponent::Base
    attr_reader :pin, :current_user, :turbo

    def initialize(pin:, current_user: nil, turbo: true)
      @pin = pin
      @current_user = current_user
      @turbo = turbo
    end

    def render?
      @current_user.present?
    end
  end
end
