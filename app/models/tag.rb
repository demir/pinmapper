# frozen_string_literal: true

class Tag < ActsAsTaggableOn::Tag
  # relations
  has_many :user_tags, dependent: :destroy
  has_many :users, through: :user_tags, dependent: :destroy
  has_many :pins, through: :taggings, source: :taggable, source_type: 'Pin'
end
