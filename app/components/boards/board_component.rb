# frozen_string_literal: true

module Boards
  class BoardComponent < ViewComponent::Base
    attr_reader :board, :current_user, :show_privacy_badge, :name_class,
                :first_twin_button_class, :second_twin_button_class

    # rubocop:disable Metrics/MethodLength
    def initialize(board:, options:)
      o = {
        current_user:             nil,
        show_privacy_badge:       false,
        name_class:               'soft-black-link',
        first_twin_button_class:  'btn_1 rounded small outline',
        second_twin_button_class: 'btn_1 rounded small'
      }.merge(options)
      @board = board
      @current_user = o[:current_user]
      @show_privacy_badge = o[:show_privacy_badge]
      @name_class = o[:name_class]
      @first_twin_button_class = o[:first_twin_button_class]
      @second_twin_button_class = o[:second_twin_button_class]
    end
    # rubocop:enable Metrics/MethodLength

    private

    def privacy_badge_class
      board.public_privacy? ? :primary : :secondary
    end
  end
end
