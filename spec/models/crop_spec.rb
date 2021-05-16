# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Crop, type: :model do
  subject(:crop) { build(:crop) }

  it 'has a valid factory' do
    expect(crop).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:cropable) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:crop_x) }
    it { is_expected.to validate_presence_of(:crop_y) }
    it { is_expected.to validate_presence_of(:crop_width) }
    it { is_expected.to validate_presence_of(:crop_height) }
  end
end
