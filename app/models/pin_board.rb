# frozen_string_literal: true

class PinBoard < ApplicationRecord
  belongs_to :pin
  belongs_to :board

  validates_uniqueness_of :board_id, scope: :pin_id
end
