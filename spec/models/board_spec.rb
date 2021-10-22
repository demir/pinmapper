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
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:privacy) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:privacy) }

    it 'translates privacy' do
      expect(described_class.respond_to?(:translated_privacies)).to be true
    end
  end
end
