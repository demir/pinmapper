# frozen_string_literal: true

class PinBoard < ApplicationRecord
  belongs_to :pin
  belongs_to :board

  validates :board_id, uniqueness: { scope: :pin_id }

  # counter_cultures
  counter_culture :board, column_name: 'pins_count'
end
