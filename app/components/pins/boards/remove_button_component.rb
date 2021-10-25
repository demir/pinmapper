# frozen_string_literal: true

module Pins
  module Boards
    class RemoveButtonComponent < ViewComponent::Base
      include Turbo::FramesHelper
      attr_reader :board, :pin, :current_user

      def initialize(board:, pin:, current_user:)
        @board = board
        @pin = pin
        @current_user = current_user
      end

      def render?
        return if current_user.blank?

        board.pins.include?(pin)
      end
    end
  end
end
