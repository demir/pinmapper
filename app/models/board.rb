# frozen_string_literal: true

class Board < ApplicationRecord
  include TranslateEnum

  # search
  include PgSearch::Model
  pg_search_scope(:search_by_name,
                  against: :name,
                  using:   { trigram: { word_similarity: true, threshold: 0.5 } })

  # relations
  belongs_to :user
  has_many :pin_boards, dependent: :destroy
  has_many :pins, through: :pin_boards, dependent: :destroy
  has_many :user_boards, dependent: :destroy
  has_many :followers, through: :user_boards, source: :user, dependent: :destroy

  # validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :privacy, presence: true

  # enums
  enum privacy: { public: 0, secret: 1 }, _suffix: true

  translate_enum :privacy
end
