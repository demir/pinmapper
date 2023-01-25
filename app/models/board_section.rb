# frozen_string_literal: true

class BoardSection < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId

  # scopes
  pg_search_scope :trigram_search_by_name,
                  against: :name,
                  using:   { trigram: { word_similarity: true, threshold: 0.5 } }

  # relations
  belongs_to :board
  has_rich_text :description
  has_many :pin_board_sections, dependent: :destroy
  has_many :pins, -> { order 'pin_board_sections.position ASC' },
           through:   :pin_board_sections,
           dependent: :destroy

  # validations
  validates :name, presence:  true,
                   length:    { maximum: 50 },
                   exclusion: { in: ReservedWords.all }
  validates :pins_count, presence: true
  validate :description_length
  validate :max_number_of_description_attachments

  # friendly_id
  friendly_id :name, use: :history

  # acts_as_list for sorting
  acts_as_list scope: :board

  def merge?
    board.board_sections.where.not(id: self).present?
  end

  private

  def description_length
    return if description.body.blank?
    return if description.body.to_plain_text.length <= 1000

    errors.add(:description, :too_long, **{ count: 1000 })
  end

  def max_number_of_description_attachments
    return if description.body.blank?
    return if description.body
                         .attachments
                         .count { |a| !a.attachable.instance_of?(::Embed) } <= 2

    errors.add(:description, :max_number_of_description_attachments)
  end
end
