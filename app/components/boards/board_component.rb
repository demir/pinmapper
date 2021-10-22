# frozen_string_literal: true

module Boards
  class BoardComponent < ViewComponent::Base
    attr_reader :board, :current_user, :show_privacy_badge, :name_class

    def initialize(board:, options:)
      o = {
        current_user:       nil,
        show_privacy_badge: false,
        name_class:         'soft-black-link'
      }.merge(options)
      @board = board
      @current_user = o[:current_user]
      @show_privacy_badge = o[:show_privacy_badge]
      @name_class = o[:name_class]
    end

    private

    def privacy_badge_class
      board.public_privacy? ? :primary : :secondary
    end
  end
end
