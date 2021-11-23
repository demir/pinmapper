# frozen_string_literal: true

class UserBoard < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :board_id, uniqueness: { scope: :user_id }

  # counter_cultures
  counter_culture :user, column_name: 'following_boards_count'
end
