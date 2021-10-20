# frozen_string_literal: true

module Boards
  class MoreButtonComponent < ViewComponent::Base
    attr_reader :board, :current_user, :turbo

    def initialize(board:, current_user:, turbo: true)
      @board = board
      @current_user = current_user
      @turbo = turbo
    end

    def render?
      current_user.present?
    end
  end
end
