# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::PinComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  context 'with current_user' do
    it 'renders pin attributes' do
      render_inline(described_class.new(pin: pin, current_user: user))
      expect(rendered_component).to have_css '.header .user .user-avatar'
      expect(rendered_component).to have_css '.header .user span', text: pin.user.email
      expect(rendered_component).to have_css '.header .pin-more'
      expect(rendered_component).to have_css '.body h3 a', text: pin.name
      expect(rendered_component).to have_css '.body .cover-image-description', text: pin.cover_image_description
      expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.first}"
      expect(rendered_component).to have_css '.body .time-ago',
                                             text: "#{time_ago_in_words(pin.created_at)} #{I18n.t('ago')}"
      expect(rendered_component).to have_css '.footer .like_btn'
    end
  end

  context 'without current_user' do
    it 'does not render more button' do
      render_inline(described_class.new(pin: pin))
      expect(rendered_component).not_to have_css '.pin-more'
    end
  end
end
