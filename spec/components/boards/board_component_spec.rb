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
        expect(page).to have_css '.board .badge-primary.privacy'
      end
    end

    context 'when secret' do
      it 'has secondary badge' do
        board_attributes = attributes_for(:board, privacy: 'secret')
        new_boards = create_list(:board, 2, board_attributes)
        render_inline(described_class.with_collection(new_boards,
                                                      options: { current_user:,
                                                                 show_privacy_badge: true }))
        expect(page).to have_css '.board .badge-secondary.privacy'
      end
    end
  end

  it 'follow/unfollow button' do
    render_inline(described_class.with_collection(boards, options: { current_user: }))
    # sadece 1 tanesini kontrol ediyor
    board = boards.first
    expect(page).to have_css "#twin_button_board_#{board.id}"
  end
end
