# frozen_string_literal: true

module BoardSections
  class BoardSectionComponent < ViewComponent::Base
    attr_reader :board_section, :current_user, :drag_sort

    def initialize(board_section:, current_user:, drag_sort: false)
      @board_section = board_section
      @current_user = current_user
      @drag_sort = drag_sort
    end
  end
end
