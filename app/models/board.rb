# frozen_string_literal: true

class Board < ApplicationRecord
  include TranslateEnum

  # relations
  belongs_to :user
  has_many :pin_boards, dependent: :destroy
  has_many :pins, through: :pin_boards, dependent: :destroy

  # validations
  validates :name, presence: true
  validates :privacy, presence: true

  # enums
  enum privacy: { public: 0, secret: 1 }, _suffix: true

  translate_enum :privacy
end
