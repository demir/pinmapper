# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pin, type: :model do
  subject(:pin) { build(:pin) }

  it 'has a valid factory' do
    expect(pin).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_ophoto_crop) }
    it { is_expected.to accept_nested_attributes_for(:cover_photo_crop) }
    it { is_expected.to have_one_attached(:cover_photo) }
    it { is_expected.to have_rich_text(:description) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:boards) }
  end

  describe 'attributes' do
    it { is_expected.to have_secure_token(:token) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(128) }
    it { is_expected.to validate_length_of(:cover_photo_description).is_at_most(500) }
    it { is_expected.to allow_value(pin.description.body.to_s).for(:description) }
    it { is_expected.to validate_presence_of(:address) }

    context 'adress presence' do
      let!(:pin) { build(:pin, address: 'FooBooFoBoFfFf') }

      it 'to be invalid' do
        expect(pin).to be_invalid
      end

      it 'error message' do
        pin.valid?
        error_message = "#{described_class.human_attribute_name(:address)} #{I18n.t('errors.messages.invalid')}"
        expect(pin.errors.full_messages).to include(error_message)
      end
    end

    context 'max tag count' do
      let!(:pin) { build(:pin, tag_list: 'dolorem,quaerat,nesciunt,voluptas,assumenda,ullam') }

      it 'to be invalid' do
        expect(pin).to be_invalid
      end

      it 'error message' do
        pin.valid?
        tag_list_human_name = described_class.human_attribute_name(:tag_list)
        error_message = "#{tag_list_human_name} #{pin.errors.generate_message(:tag_list, :max_tag_count)}"
        expect(pin.errors.full_messages).to include(error_message)
      end
    end

    context 'max tag length' do
      let!(:pin) { build(:pin, tag_list: Array(Faker::Lorem.characters(number: 31, min_alpha: 31))) }

      it 'to be invalid' do
        expect(pin).to be_invalid
      end

      it 'error message' do
        pin.valid?
        tag_list_human_name = described_class.human_attribute_name(:tag_list)
        error_message = "#{tag_list_human_name} #{pin.errors.generate_message(:tag_list, :max_tag_length)}"
        expect(pin.errors.full_messages).to include(error_message)
      end
    end
  end

  describe 'scopes' do
    it 'search_pins' do
      random_name = SecureRandom.hex(15)
      pin = create(:pin, name: random_name)
      expect(described_class.pg_search(random_name)).to include(pin)
    end
  end
end
