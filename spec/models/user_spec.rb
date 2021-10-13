# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:pins) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:following) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }

    it do
      expect(user).to validate_length_of(:password).is_at_least(6)
                                                   .is_at_most(128)
    end
  end
end
