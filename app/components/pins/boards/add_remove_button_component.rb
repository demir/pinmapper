# frozen_string_literal: true

module Pins
  module Boards
    class AddRemoveButtonComponent < ViewComponent::Base
      include Turbo::FramesHelper
      attr_reader :board, :pin, :current_user, :board_section_button

      def initialize(board:, pin:, current_user:, board_section_button: false)
        @board = board
        @pin = pin
        @current_user = current_user
        @board_section_button = board_section_button
      end

      def render?
        return if current_user.blank?

        board.user == current_user
      end
    end
  end
end
