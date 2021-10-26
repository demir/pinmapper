# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PinBoard, type: :model do
  subject(:pin_board) { build(:pin_board) }

  it 'has a valid factory' do
    expect(pin_board).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:pin) }
    it { is_expected.to belong_to(:board) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:board_id).scoped_to(:pin_id) }
  end
end
