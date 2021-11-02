# frozen_string_literal: true

class PinBoard < ApplicationRecord
  belongs_to :pin
  belongs_to :board

  validates :board_id, uniqueness: { scope: :pin_id }
end
