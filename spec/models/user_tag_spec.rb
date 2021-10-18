# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTag, type: :model do
  subject(:user_tag) { build(:user_tag) }

  it 'has a valid factory' do
    expect(user_tag).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:tag) }
  end
end
