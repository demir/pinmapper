class BoardSection < ApplicationRecord
  extend FriendlyId

  # relations
  belongs_to :board
  has_many :pin_board_sections, dependent: :destroy
  has_many :pins, -> { order 'pin_board_sections.position ASC' },
           through:   :pin_board_sections,
           dependent: :destroy

  # validations
  validates :name, presence:  true,
                   length:    { maximum: 50 },
                   exclusion: { in: ReservedWords.all }
  validates :pins_count, presence: true

  # friendly_id
  friendly_id :name, use: :history
end
