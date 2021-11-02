# frozen_string_literal: true

module Boards
  class MoreButtonComponent < ViewComponent::Base
    attr_reader :board, :current_user, :turbo

    def initialize(board:, current_user: nil, turbo: true)
      @board = board
      @current_user = current_user
      @turbo = turbo
    end

    def render?
      board.user == current_user
    end
  end
end
