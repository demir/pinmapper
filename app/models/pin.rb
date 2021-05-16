# frozen_string_literal: true

class Pin < ApplicationRecord
  include TranslateEnum
  acts_as_taggable_on :tags
  geocoded_by :address do |obj, results|
    if results.present?
      obj.latitude = results.first.latitude
      obj.longitude = results.first.longitude
    else
      obj.latitude = nil
      obj.longitude = nil
    end
  end

  # callbacks
  before_destroy :delete_crops
  before_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }
  before_validation :fix_tags, if: :tag_list_changed?

  # relations
  has_one :cover_image_crop, as: :cropable, class_name: 'Crop'
  accepts_nested_attributes_for :cover_image_crop, update_only: true
  has_one_attached :cover_image
  has_rich_text :description
  belongs_to :user

  # validations
  validates :name, presence: true
  validates :address, presence: true
  validate :found_address_presence?, if: ->(obj) { obj.address.present? && obj.address_changed? }
  validates :privacy, presence: true
  validate :max_tag_count, if: :tag_list_changed?
  validate :max_tag_length, if: :tag_list_changed?

  # enums
  enum privacy: { private: 0, public: 1 }, _suffix: true

  translate_enum :privacy

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

  def found_address_presence?
    return if latitude.present? && longitude.present?

    errors.add(:address, :invalid)
  end

  def fix_tags
    tag_list_downcased = tag_list.to_s.downcase(:turkic)
    self.tag_list = tag_list_downcased.gsub(/[^a-z0-9,öçğışü]/, '').split(',')
  end

  def max_tag_count
    return if tag_list.count <= 5

    errors.add(:tag_list, :max_tag_count)
  end

  def max_tag_length
    return if tag_list.collect(&:length).max <= 30

    errors.add(:tag_list, :max_tag_length)
  end
end
