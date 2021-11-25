ActsAsTaggableOn.remove_unused_tags = true

ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId

  friendly_id :name, use: :slugged

  # relations
  has_many :pins, through: :taggings, source: :taggable, source_type: 'Pin'
  has_many :user_tags, dependent: :destroy
  has_many :users, through: :user_tags, dependent: :destroy
end
