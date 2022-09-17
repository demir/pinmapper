# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::MoreButtonComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user:) }

  context 'with current_user' do
    context 'if owner of pin' do
      before do
        render_inline(described_class.new(pin:, current_user: user))
      end

      it 'more button' do
        expect(page).to have_css '.pin-more .bi-three-dots'
      end

      it 'renders #edit' do
        expect(page).to have_css '.pin-more .dropdown-menu a', text: I18n.t('edit')
      end

      it 'renders #destroy' do
        expect(page).to have_css '.pin-more .dropdown-menu a', text: I18n.t('destroy')
      end
    end

    context 'if not the owner of pin' do
      before do
        different_user = create(:user, :confirmed)
        render_inline(described_class.new(pin:, current_user: different_user))
      end

      it 'does not render button' do
        expect(page).not_to have_css '.dropdown .dropleft .pin-more'
      end

      it 'does not render #edit' do
        expect(page).not_to have_css '.pin-more .dropdown-menu a', text: I18n.t('edit')
      end

      it 'does not render #destroy' do
        expect(page).not_to have_css '.pin-more .dropdown-menu a', text: I18n.t('destroy')
      end
    end
  end

  context 'without current_user' do
    it 'does not render more button' do
      render_inline(described_class.new(pin:))
      expect(page).not_to have_css '.pin-more'
    end
  end
end
