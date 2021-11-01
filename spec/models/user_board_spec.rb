# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBoard, type: :model do
  subject(:user_board) { build(:user_board) }

  it 'has a valid factory' do
    expect(user_board).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:board) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:board_id).scoped_to(:user_id) }
  end
end
