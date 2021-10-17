class Tag < ActsAsTaggableOn::Tag
  has_many :user_tags
  has_many :users, through: :user_tags, dependent: :destroy
  has_many :pins, through: :taggings, source: :taggable, source_type: 'Pin'
end
