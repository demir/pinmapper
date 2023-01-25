# frozen_string_literal: true

module Pins
  class SmallPinComponent < ViewComponent::Base
    with_collection_parameter :pin
    attr_reader :pin, :current_user, :board, :board_section, :drag_sort

    # rubocop:disable Metrics/MethodLength
    def initialize(pin:, options:)
      o = {
        current_user:  nil,
        board:         nil,
        board_section: nil,
        drag_sort:     false
      }.merge(options)

      @pin = pin
      @current_user = o[:current_user]
      @board = o[:board]
      @board_section = o[:board_section]
      @drag_sort = o[:drag_sort]
    end
    # rubocop:enable Metrics/MethodLength

    private

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def move_url
      return '' if pin.blank? || drag_sort.blank? || current_user.blank?
      return '' if board.blank? && board_section.blank?

      if board.present?
        move_pin_board_path(board, pin.id)
      elsif board_section.present?
        move_pin_board_section_path(board_section, pin.id)
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end
end
