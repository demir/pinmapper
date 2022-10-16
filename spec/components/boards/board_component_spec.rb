# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Boards::BoardComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:boards) { create_list(:board, 10) }

  it 'board#name link' do
    render_inline(described_class.with_collection(boards, options: { current_user: }))
    expect(page).to have_css '.board span > a'
  end

  describe 'board#privacy' do
    context 'when public' do
      it 'has primary badge' do
        render_inline(described_class.with_collection(boards,
                                                      options: { current_user:,
                                                                 show_privacy_badge: true }))
        expect(page).to have_css '.board .bg-primary.privacy'
      end
    end

    context 'when secret' do
      it 'has secondary badge' do
        board_attributes = attributes_for(:board, privacy: 'secret')
        new_boards = create_list(:board, 2, board_attributes)
        render_inline(described_class.with_collection(new_boards,
                                                      options: { current_user:,
                                                                 show_privacy_badge: true }))
        expect(page).to have_css '.board .bg-secondary.privacy'
      end
    end
  end

  it 'follow/unfollow button' do
    render_inline(described_class.with_collection(boards, options: { current_user: }))
    # sadece 1 tanesini kontrol ediyor
    board = boards.first
    expect(page).to have_css "#twin_button_board_#{board.id}"
  end

  context 'data sort url' do
    let(:board) { boards.second }

    context 'with current_user' do
      before do
        render_inline(described_class.with_collection(boards,
                                                      options: { current_user:,
                                                                 show_privacy_badge: true,
                                                                 drag_sort:          true }))
      end

      it 'data sort url' do
        move_board_by_id_path = move_board_by_id_board_path(board, locale: I18n.locale)
        expect(page).to have_css ".board[data-sort-url='#{move_board_by_id_path}']"
      end
    end

    context 'without current_user' do
      before do
        render_inline(described_class.with_collection(boards,
                                                      options: { current_user:       nil,
                                                                 show_privacy_badge: true,
                                                                 drag_sort:          true }))
      end

      it 'data sort url' do
        expect(page).to have_css '.board[data-sort-url=""]'
      end
    end

    context 'when drag_sort false' do
      before do
        render_inline(described_class.with_collection(boards,
                                                      options: { current_user:,
                                                                 show_privacy_badge: true,
                                                                 drag_sort:          false }))
      end

      it 'data sort url' do
        expect(page).to have_css '.board[data-sort-url=""]'
      end
    end
  end
end
