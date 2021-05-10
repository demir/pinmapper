class Crop < ApplicationRecord
  # relations
  belongs_to :cropable, polymorphic: true

  # validations
  validates :crop_x, presence: true
  validates :crop_y, presence: true
  validates :crop_width, presence: true
  validates :crop_height, presence: true
end
