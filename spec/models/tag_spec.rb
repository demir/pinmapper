# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject(:tag) { build(:tag) }

  it 'has a valid factory' do
    expect(tag).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:pins) }
  end
end
