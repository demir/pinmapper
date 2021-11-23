# frozen_string_literal: true

class UserTag < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  # counter_cultures
  counter_culture :user, column_name: 'tags_count'
end
