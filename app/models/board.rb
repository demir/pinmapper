# frozen_string_literal: true

class Board < ApplicationRecord
  include ActiveRecord::Searchable
  include TranslateEnum

  # scopes
  pg_search_scope :trigram_search_by_name,
                  against: :name,
                  using:   { trigram: { word_similarity: true, threshold: 0.5 } }

  # relations
  belongs_to :user
  has_many :pin_boards, dependent: :destroy
  has_many :pins, through: :pin_boards, dependent: :destroy
  has_many :user_boards, dependent: :destroy
  has_many :followers, through: :user_boards, source: :user, dependent: :destroy

  # validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :privacy, presence: true
  validates :pins_count, presence: true

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
end
