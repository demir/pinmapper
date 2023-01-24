# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardSection, type: :model do
  subject(:board_section) { build(:board_section) }

  it 'has a valid factory' do
    expect(board_section).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:board) }
    it { is_expected.to have_many(:pins) }
    it { is_expected.to have_rich_text(:description) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:description).is_at_most(1000) }
    it { is_expected.to validate_presence_of(:pins_count) }
  end

  describe 'scopes' do
    it 'trigram_search_by_name' do
      random_name = SecureRandom.hex(15)
      board_section = create(:board_section, name: random_name)
      expect(described_class.trigram_search_by_name(random_name)).to include(board_section)
    end
  end
end
