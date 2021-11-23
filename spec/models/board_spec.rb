# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  subject(:board) { build(:board) }

  it 'has a valid factory' do
    expect(board).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:pins) }
    it { is_expected.to have_many(:followers) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:privacy) }
    it { is_expected.to validate_presence_of(:pins_count) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:privacy) }

    it 'translates privacy' do
      expect(described_class.respond_to?(:translated_privacies)).to be true
    end
  end

  describe 'scopes' do
    it 'trigram_search_by_name' do
      random_name = SecureRandom.hex(15)
      board = create(:board, name: random_name)
      expect(described_class.trigram_search_by_name(random_name)).to include(board)
    end

    it 'search boards' do
      random_name = SecureRandom.hex(15)
      board = create(:board, name: random_name)
      expect(described_class.pg_search(random_name)).to include(board)
    end
  end
end
