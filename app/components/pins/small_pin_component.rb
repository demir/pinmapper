# frozen_string_literal: true

module Pins
  class SmallPinComponent < ViewComponent::Base
    with_collection_parameter :pin
    attr_reader :pin, :current_user, :board

    def initialize(pin:, current_user:, board: nil)
      @pin = pin
      @current_user = current_user
      @board = board
    end

    private

    def move_pin_url
      return '' if board.blank? || pin.blank?

      move_pin_board_path(board, pin.id)
    end
  end
end
