# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  # counter_cultures
  counter_culture :follower, column_name: 'following_count'
  counter_culture :following, column_name: 'followers_count'
end
