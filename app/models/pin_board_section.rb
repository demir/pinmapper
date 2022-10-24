class PinBoardSection < ApplicationRecord
  default_scope -> { order(position: :asc) }

  belongs_to :pin
  belongs_to :board_section

  validates :board_section_id, uniqueness: { scope: :pin_id }

  # counter_cultures
  counter_culture :board_section, column_name: 'pins_count'

  # acts_as_list for sorting
  acts_as_list scope: :board_section
end
