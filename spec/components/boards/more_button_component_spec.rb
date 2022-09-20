# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Boards::MoreButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }

  context 'with current_user' do
    context 'if owner of board' do
      before do
        render_inline(described_class.new(board:, current_user:))
      end

      it 'more button' do
        expect(page).to have_css '.board-more .bi-three-dots'
      end

      it 'renders #edit' do
        expect(page).to have_css '.board-more .dropdown-menu a', text: I18n.t('edit')
      end

      it 'renders #destroy' do
        expect(page).to have_css '.board-more .dropdown-menu a', text: I18n.t('destroy')
      end
    end

    context 'if not the owner of board' do
      before do
        different_user = create(:user, :confirmed)
        render_inline(described_class.new(board:, current_user: different_user))
      end

      it 'does not render button' do
        expect(page).not_to have_css '.dropdown .dropstart .pin-more'
      end

      it 'does not render #edit' do
        expect(page).not_to have_css '.board-more .dropdown-menu a', text: I18n.t('edit')
      end

      it 'does not render #destroy' do
        expect(page).not_to have_css '.board-more .dropdown-menu a', text: I18n.t('destroy')
      end
    end
  end

  context 'without current_user' do
    it 'does not render more button' do
      render_inline(described_class.new(board:))
      expect(page).not_to have_css '.board-more'
    end
  end
end
