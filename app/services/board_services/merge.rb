# frozen_string_literal: true

module BoardServices
  class Merge < ApplicationService
    attr_reader :from, :to

    def initialize(from:, to:)
      @from = from
      @to = to
    end

    def call
      merge_result = merge
    rescue StandardError => e
      { success: merge_result, error: e }
    else
      { success: merge_result, payload: merge_result }
    end

    private

    def merge
      is_merged = true
      ActiveRecord::Base.transaction do
        from.board_sections.each do |from_board_section|
          new_board_section_name = new_section_name(from_board_section_name: from_board_section.name)
          from_board_section.update(board: to, name: new_board_section_name)
        end
        if from.pins.any?
          new_other_section_name = new_section_name(from_board_section_name: I18n.t('other'))
          new_other_section = BoardSection.create(board: to, name: new_other_section_name)
          new_other_section.pins << from.pins
        end
        from.reload
        from.destroy
      rescue ActiveRecord::StatementInvalid
        is_merged = false
      end
      is_merged
    end

    def new_section_name(from_board_section_name:, count: 0)
      end_of_name = count.zero? ? '' : " (#{count})"
      name = "#{from.name} - #{from_board_section_name}#{end_of_name}"
      to.board_sections.exists?(name:) ? new_section_name(from_board_section_name:, count: count + 1) : name
    end
  end
end
