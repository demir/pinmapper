# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject(:profile) { build(:profile) }

  it 'has a valid factory' do
    expect(profile).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_one(:avatar_crop) }
    it { is_expected.to accept_nested_attributes_for(:avatar_crop) }
    it { is_expected.to have_one_attached(:avatar) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:bio).is_at_most(160) }
  end
end
