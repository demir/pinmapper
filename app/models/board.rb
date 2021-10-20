class Board < ApplicationRecord
  include TranslateEnum

  # relations
  belongs_to :user

  # validations
  validates :name, presence: true
  validates :privacy, presence: true

  # enums
  enum privacy: { public: 0, secret: 1 }, _suffix: true

  translate_enum :privacy
end
