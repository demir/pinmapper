# frozen_string_literal: true

module Pins
  module Boards
    class AddToBoardButtonComponent < ViewComponent::Base
      attr_reader :pin, :current_user

      def initialize(pin:, current_user:)
        @pin = pin
        @current_user = current_user
      end

      def render?
        current_user.present?
      end
    end
  end
end
