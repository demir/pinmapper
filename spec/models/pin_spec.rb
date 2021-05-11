require 'rails_helper'

RSpec.describe Pin, type: :model do
  subject { build(:pin) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_one(:cover_image_crop) }
    it { is_expected.to accept_nested_attributes_for(:cover_image_crop) }
    it { is_expected.to have_one_attached(:cover_image) }
    it { is_expected.to have_rich_text(:description) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:privacy) }

    it 'validates that address presence' do
      pin = build(:pin, address: 'FooBooFoBoFfFf')
      expect(pin).to be_invalid
      error_message = "#{Pin.human_attribute_name(:address)} #{I18n.t('errors.messages.invalid')}"
      expect(pin.errors.full_messages).to include(error_message)
    end

    it 'validates max tag count' do
      pin = build(:pin, tag_list: 'dolorem,quaerat,nesciunt,voluptas,assumenda,ullam')
      expect(pin).to be_invalid
      error_message = "#{Pin.human_attribute_name(:tag_list)} #{pin.errors.generate_message(:tag_list, :max_tag_count)}"
      expect(pin.errors.full_messages).to include(error_message)
    end

    it 'validates max tag length' do
      pin = build(:pin, tag_list: Array(Faker::Lorem.characters(number: 31, min_alpha: 31)))
      expect(pin).to be_invalid
      error_message = "#{Pin.human_attribute_name(:tag_list)} #{pin.errors.generate_message(:tag_list,
                                                                                            :max_tag_length)}"
      expect(pin.errors.full_messages).to include(error_message)
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:privacy) }

    it 'translates privacy' do
      expect(described_class.respond_to?(:translated_privacies)).to be true
    end
  end
end
