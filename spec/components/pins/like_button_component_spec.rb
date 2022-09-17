# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::LikeButtonComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user:) }

  context 'with current_user' do
    context 'if it is unliked' do
      before do
        render_inline(described_class.new(pin:, current_user: user))
      end

      it 'path' do
        href = like_pin_path(id: pin, locale: I18n.locale)
        expect(page).to have_css ".pin-likes-count .like_btn[href~='#{href}']"
      end
    end

    context 'if it is liked' do
      before do
        pin.liked_by user
        render_inline(described_class.new(pin:, current_user: user))
      end

      it 'path' do
        href = unlike_pin_path(id: pin, locale: I18n.locale)
        expect(page).to have_css ".pin-likes-count .like_btn.liked[href~='#{href}']"
      end
    end
  end

  context 'without current_user' do
    before do
      render_inline(described_class.new(pin:, current_user: nil))
    end

    it 'path' do
      expect(page).to have_css ".pin-likes-count .like_btn.disabled[href~='#']"
    end
  end
end
