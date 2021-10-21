# frozen_string_literal: true

module Boards
  class BoardComponent < ViewComponent::Base
    attr_reader :board, :current_user

    def initialize(board:, current_user:)
      @board = board
      @current_user = current_user
    end

    private

    def privacy_badge_class
      board.public_privacy? ? :primary : :secondary
    end
  end
end
