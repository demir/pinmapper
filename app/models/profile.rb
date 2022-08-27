# frozen_string_literal: true

class Profile < ApplicationRecord
  # callbacks
  before_destroy :delete_crops

  # relations
  belongs_to :user
  has_one :avatar_crop, as: :cropable, class_name: 'Crop', dependent: :destroy
  accepts_nested_attributes_for :avatar_crop, update_only: true
  has_one_attached :avatar

  # validations
  validates :bio, length: { maximum: 160 }

  def avatar_crop_constraints
    return {} if avatar_crop.blank?

    {
      height: avatar_crop.crop_height.to_i,
      width:  avatar_crop.crop_width.to_i,
      x:      avatar_crop.crop_x.to_i,
      y:      avatar_crop.crop_y.to_i,
      crop:   'crop'
    }
  end

  private

  def delete_crops
    return if avatar_crop.blank?

    avatar_crop.destroy
  end
end
