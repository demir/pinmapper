# frozen_string_literal: true

module Boards
  class BoardComponent < ViewComponent::Base
    attr_reader :board, :current_user, :show_privacy_badge, :name_class,
                :first_twin_button_class, :second_twin_button_class, :drag_sort

    # rubocop:disable Metrics/MethodLength
    def initialize(board:, options:)
      o = {
        current_user:             nil,
        show_privacy_badge:       false,
        drag_sort:                false,
        name_class:               'black-link',
        first_twin_button_class:  'btn_1 rounded small outline',
        second_twin_button_class: 'btn_1 rounded small'
      }.merge(options)
      @board = board
      @current_user = o[:current_user]
      @show_privacy_badge = o[:show_privacy_badge]
      @drag_sort = o[:drag_sort]
      @name_class = o[:name_class]
      @first_twin_button_class = o[:first_twin_button_class]
      @second_twin_button_class = o[:second_twin_button_class]
    end
    # rubocop:enable Metrics/MethodLength

    private

    def privacy_badge_class
      board.public_privacy? ? :primary : :secondary
    end

    def move_board_by_id_url
      return '' if board.blank? || drag_sort.blank? || current_user.blank?

      move_board_by_id_board_path(board)
    end
  end
end
