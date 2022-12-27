# frozen_string_literal: true

module BoardSections
  class ListItemForPinComponent < ViewComponent::Base
    with_collection_parameter :board_section
    attr_reader :board_section, :pin, :current_user, :drag_sort

    def initialize(board_section:, pin:, current_user:, drag_sort: false)
      @board_section = board_section
      @pin = pin
      @current_user = current_user
      @drag_sort = drag_sort
    end

    private

    def move_url
      return '' if board_section.blank? || drag_sort.blank? || current_user.blank?

      move_board_section_path(board_section)
    end

    def render_add_remove_button?
      pin.present?
    end
  end
end
