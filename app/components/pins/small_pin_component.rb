# frozen_string_literal: true

module Pins
  class SmallPinComponent < ViewComponent::Base
    with_collection_parameter :pin
    attr_reader :pin, :current_user, :board, :drag_sort

    def initialize(pin:, current_user:, board: nil, drag_sort: false)
      @pin = pin
      @current_user = current_user
      @board = board
      @drag_sort = drag_sort
    end

    private

    def move_pin_url
      return '' if board.blank? || pin.blank? || drag_sort.blank? || current_user.blank?

      move_pin_board_path(board, pin.id)
    end
  end
end
