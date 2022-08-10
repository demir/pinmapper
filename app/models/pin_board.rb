# frozen_string_literal: true

class PinBoard < ApplicationRecord
  default_scope -> { order(position: :asc) }

  belongs_to :pin
  belongs_to :board

  validates :board_id, uniqueness: { scope: :pin_id }

  # counter_cultures
  counter_culture :board, column_name: 'pins_count'

  # acts_as_list for sorting
  acts_as_list scope: :board
end
