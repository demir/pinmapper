# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::PinComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  context 'pin attributes with current_user' do
    before do
      render_inline(described_class.new(pin: pin, current_user: user))
    end

    it 'user#avatar' do
      expect(rendered_component).to have_css '.header .user .user-avatar'
    end

    it 'user#username' do
      expect(rendered_component).to have_css '.header .user span', text: pin.user.username
    end

    it 'more button' do
      expect(rendered_component).to have_css '.header .pin-more'
    end

    it 'pin#name' do
      expect(rendered_component).to have_css '.body h3 a', text: pin.name
    end

    it 'pin#cover_image_description' do
      expect(rendered_component).to have_css '.body .cover-image-description',
                                             text: pin.cover_image_description
    end

    it 'pin#tag_list.first' do
      expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.first}"
    end

    it 'time ago' do
      expect(rendered_component).to have_css '.body .time-ago',
                                             text: "#{time_ago_in_words(pin.created_at)} #{I18n.t('ago')}"
    end

    it 'like button' do
      expect(rendered_component).to have_css '.footer .like_btn'
    end

    it 'add to board button' do
      expect(rendered_component).to have_css '.footer .add_to_board_btn'
    end
  end

  context 'without current_user' do
    it 'does not render more button' do
      render_inline(described_class.new(pin: pin))
      expect(rendered_component).not_to have_css '.pin-more'
    end
  end
end
