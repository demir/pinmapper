# frozen_string_literal: true

class Pin < ApplicationRecord
  extend FriendlyId
  include ActiveRecord::Searchable

  acts_as_taggable_on :tags
  acts_as_votable
  geocoded_by :address do |obj, results|
    if results.present?
      obj.latitude = results.first.latitude
      obj.longitude = results.first.longitude
    else
      obj.latitude = nil
      obj.longitude = nil
    end
  end

  # secure_token
  has_secure_token

  # friendly_id
  friendly_id :name, use: :history

  # delegates
  delegate :username, to: :user, prefix: true

  # callbacks
  before_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }
  before_validation :fix_tags, if: :tag_list_changed?
  before_save :set_caches
  before_update :delete_user_tags, prepend: true
  before_destroy :delete_crops
  before_destroy :delete_user_tags, prepend: true

  # relations
  has_one :cover_photo_crop, as: :cropable, class_name: 'Crop', dependent: :destroy
  accepts_nested_attributes_for :cover_photo_crop, update_only: true
  has_one_attached :cover_photo
  has_rich_text :description
  belongs_to :user
  has_many :pin_boards, dependent: :destroy
  has_many :boards, -> { order 'pin_boards.position ASC' }, through: :pin_boards, dependent: :destroy

  # validations
  validates :name, presence: true, length: { maximum: 128 }
  validates :cover_photo_description, length: { maximum: 500 }
  validates :address, presence: true
  validate :found_address_presence?, if: ->(obj) { obj.address.present? && obj.address_changed? }
  validate :max_tag_count, if: :tag_list_changed?
  validate :max_tag_length, if: :tag_list_changed?
  validate :description_length
  validate :max_number_of_description_attachments

  # counter_cultures
  counter_culture :user

  def cover_photo_crop_constraints
    return {} if cover_photo_crop.blank?

    {
      height: cover_photo_crop.crop_height.to_i,
      width:  cover_photo_crop.crop_width.to_i,
      x:      cover_photo_crop.crop_x.to_i,
      y:      cover_photo_crop.crop_y.to_i,
      crop:   'crop'
    }
  end

  def city_country
    address.split(',').last(2).join(',').strip
  end

  def owner_public_boards
    boards.where(user:, privacy: 'public').order('pin_boards.created_at ASC')
  end

  private

  def delete_crops
    return if cover_photo_crop.blank?

    cover_photo_crop.destroy
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

  def delete_user_tags
    UserTag.where(tag: tags.where(taggings_count: 1)).destroy_all
  end

  def set_caches
    self.cached_tag_list = tag_list.to_s
    self.cached_plain_text_description = description&.body&.to_plain_text
    return if user.blank?

    self.cached_user_username = user_username
  end

  def should_generate_new_friendly_id?
    name.present? && name_changed?
  end

  def description_length
    return if description.body.to_plain_text.length <= 5000

    errors.add(:description, :too_long, **{ count: 5000 })
  end

  def max_number_of_description_attachments
    return if description.body
                         .attachments
                         .reject { |a| a.attachable.instance_of?(::Embed) }
                         .count <= 6

    errors.add(:description, :max_number_of_description_attachments)
  end
end
