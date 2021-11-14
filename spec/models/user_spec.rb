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
    it { is_expected.to have_many(:tags) }
    it { is_expected.to have_many(:boards) }
    it { is_expected.to have_many(:following_boards) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).ignoring_case_sensitivity }
    it { is_expected.to validate_length_of(:username).is_at_most(30) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }

    it do
      expect(user).to validate_length_of(:password).is_at_least(6)
                                                   .is_at_most(128)
    end
  end

  describe 'scopes' do
    it 'search_users' do
      random_name = SecureRandom.hex(15)
      user = create(:user, username: random_name)
      expect(described_class.search_users(random_name)).to include(user)
    end
  end
end
