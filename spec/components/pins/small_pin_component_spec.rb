# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::SmallPinComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  context 'pin attributes' do
    before do
      render_inline(described_class.new(pin: pin, current_user: user))
    end

    it 'user#image class' do
      expect(rendered_component).to have_css '.small-pin .image'
    end

    it 'user#username' do
      expect(rendered_component).to have_css '.small-pin .body small .black-link-555555', text: pin.user.username
    end

    it 'pin#name' do
      expect(rendered_component).to have_css '.small-pin .body h6 a.black-link', text: pin.name
    end

    it 'location icon' do
      expect(rendered_component).to have_css '.small-pin .body .icon_pin_alt'
    end

    it 'location information' do
      expect(rendered_component).to have_css '.small-pin .body small.address', text: pin.city_country
    end
  end
end
