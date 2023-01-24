require 'rails_helper'

RSpec.describe PinBoardSection, type: :model do
  subject(:pin_board_section) { build(:pin_board_section) }

  it 'has a valid factory' do
    expect(pin_board_section).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:pin) }
    it { is_expected.to belong_to(:board_section) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:board_section_id).scoped_to(:pin_id) }
  end
end
