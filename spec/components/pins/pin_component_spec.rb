# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::PinComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user:) }

  context 'pin attributes with current_user' do
    before do
      render_inline(described_class.new(pin:, current_user: user))
    end

    it 'user#avatar' do
      expect(page).to have_css '.header .user .user-avatar'
    end

    it 'user#username' do
      expect(page).to have_css '.header .user span', text: pin.user.username
    end

    it 'more button' do
      expect(page).to have_css '.header .pin-more'
    end

    it 'pin#name' do
      expect(page).to have_css '.body h3 a', text: pin.name
    end

    it 'pin#cover_photo_description' do
      expect(page).to have_css '.body .cover-photo-description',
                               text: pin.cover_photo_description
    end

    it 'pin#tag_list.first' do
      expect(page).to have_css '.pin-tag', text: "##{pin.tag_list.first}"
    end

    it 'time ago' do
      expect(page).to have_css '.header .time-ago',
                               text: "#{time_ago_in_words(pin.created_at)} #{I18n.t('ago')}"
    end

    it 'like button' do
      expect(page).to have_css '.footer .like_btn'
    end

    it 'add to board button' do
      expect(page).to have_css '.footer .add_to_board_btn'
    end

    it 'location link' do
      expect(page).to have_css '.pin .body .address a', text: pin.city_country
    end
  end

  context 'without current_user' do
    it 'does not render more button' do
      render_inline(described_class.new(pin:))
      expect(page).not_to have_css '.pin-more'
    end
  end
end
