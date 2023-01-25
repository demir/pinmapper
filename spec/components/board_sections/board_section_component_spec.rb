# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardSections::BoardSectionComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }
  let(:board_sections) { create_list(:board_section, 10, board:) }

  context 'without current_user' do
    before do
      render_inline(described_class.with_collection(board_sections, current_user: nil))
    end

    it 'not renders more button #edit' do
      expect(page).not_to have_css '.board-section .general-more .dropdown-item', text: I18n.t('edit')
    end

    it 'data sort url' do
      expect(page).to have_css '.board-section[data-sort-url=""]'
    end
  end

  context 'with current_user' do
    context 'with multiple board sections' do
      before do
        render_inline(described_class.with_collection(board_sections, current_user:))
      end

      it 'renders more button #edit' do
        expect(page).to have_css '.board-section .general-more .dropdown-item', text:  I18n.t('edit')
      end

      it 'renders more button #destroy' do
        expect(page).to have_css '.board-section .general-more .dropdown-item', text:  I18n.t('destroy')
      end

      it 'renders more button #merge' do
        expect(page).to have_css '.board-section .general-more .dropdown-menu .dropdown-item', text: I18n.t('merge')
      end
    end

    it 'not renders more button #merge with single board section' do
      new_board_sections = create_list(:board_section, 1, board:)
      render_inline(described_class.with_collection(new_board_sections, current_user:))
      expect(page).not_to have_css '.board-section .general-more .dropdown-menu .dropdown-item',
                                   text: I18n.t('merge')
    end

    it 'data sort url' do
      board_section = board_sections.first
      move_board_section_path = move_board_section_path(board_section, locale: I18n.locale)
      render_inline(described_class.with_collection(board_sections, current_user:, drag_sort: true))
      expect(page).to have_css ".board-section[data-sort-url='#{move_board_section_path}']"
    end

    it 'data sort url when drag_sort false' do
      render_inline(described_class.with_collection(board_sections, current_user:, drag_sort: false))
      expect(page).to have_css '.board-section[data-sort-url=""]'
    end
  end

  context 'regardless of current_user' do
    before do
      render_inline(described_class.with_collection(board_sections, current_user: nil))
    end

    it 'board_section#name link' do
      expect(page).to have_css '.board-section > .board-section-body > a.name.black-link'
    end

    it 'board_section#pins count' do
      expect(page).to have_css '.board-section > .board-section-body > p.pins-count'
    end
  end
end
