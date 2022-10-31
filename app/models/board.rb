# frozen_string_literal: true

class Board < ApplicationRecord
  extend FriendlyId
  include ActiveRecord::Searchable
  include TranslateEnum

  # scopes
  pg_search_scope :trigram_search_by_name,
                  against: :name,
                  using:   { trigram: { word_similarity: true, threshold: 0.5 } }

  # relations
  belongs_to :user
  has_many :pin_boards, dependent: :destroy
  has_many :pins, -> { order 'pin_boards.position ASC' }, through: :pin_boards, dependent: :destroy
  has_many :user_boards, dependent: :destroy
  has_many :followers, through: :user_boards, source: :user, dependent: :destroy
  has_many :board_sections, -> { order 'board_sections.position ASC' }, dependent: :destroy
  has_rich_text :description

  # validations
  validates :name, presence:  true,
                   length:    { maximum: 50 },
                   exclusion: { in: ReservedWords.all }
  validates :privacy, presence: true
  validates :pins_count, presence: true
  validate :description_length
  validate :max_number_of_description_attachments

  # friendly_id
  friendly_id :name, use: :history

  # acts_as_list for sorting
  acts_as_list scope: :user

  # counter_cultures
  counter_culture :user
  counter_culture :user,
                  column_name:  proc { |model| "#{model.privacy}_boards_count" },
                  column_names: {
                    ['boards.privacy = ?', 0] => 'public_boards_count',
                    ['boards.privacy = ?', 1] => 'secret_boards_count'
                  }

  # enums
  enum privacy: { public: 0, secret: 1 }, _suffix: true

  translate_enum :privacy

  def cached_pins_count
    pins_count + board_sections.sum(:pins_count)
  end

  private

  def description_length
    return if description.body.to_plain_text.length <= 1000

    errors.add(:description, :too_long, **{ count: 1000 })
  end

  def max_number_of_description_attachments
    return if description.body
                         .attachments
                         .count { |a| !a.attachable.instance_of?(::Embed) } <= 2

    errors.add(:description, :max_number_of_description_attachments)
  end
end
