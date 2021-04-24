class Pin < ApplicationRecord
  include TranslateEnum
  # callbacks
  before_destroy :delete_crops

  # relations
  has_one :cover_image_crop, as: :cropable, class_name: 'Crop'
  accepts_nested_attributes_for :cover_image_crop, update_only: true
  has_one_attached :cover_image

  # enums
  enum category: { food: 0, coffee: 1, nightlife: 2, fun: 3, shopping: 4 }
  enum privacy: { private: 0, public: 1 }, _suffix: true

  translate_enum :category
  translate_enum :privacy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def cover_image_crop_constraints
    return {} if cover_image_crop.blank?
    return {} unless cover_image_crop.crop_x && cover_image_crop.crop_y &&
                     cover_image_crop.crop_width && cover_image_crop.crop_height

    {
      crop:
            [
              cover_image_crop.crop_x.to_f,
              cover_image_crop.crop_y.to_f,
              cover_image_crop.crop_width.to_f,
              cover_image_crop.crop_height.to_f
            ]
    }
  end

  private

  def delete_crops
    return if cover_image_crop.blank?

    cover_image_crop.destroy
  end
end
