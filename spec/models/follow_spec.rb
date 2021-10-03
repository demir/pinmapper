# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  subject(:follow) { build(:follow) }

  it 'has a valid factory' do
    expect(follow).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:following) }
  end
end
