# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Boards::ListItemForPinComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:boards) { create_list(:board, 3) }
  let(:pin) { create(:pin) }

  before do
    render_inline(described_class.with_collection(boards, pin:, current_user:))
  end

  context 'without current_user' do
    before do
      render_inline(described_class.with_collection(boards, pin:, current_user: nil))
    end

    it 'board name' do
      expect(page).not_to have_css '.board-name'
    end

    it 'add or remove button' do
      expect(page).not_to have_css '.btn_1'
    end
  end

  context 'with current_user' do
    it 'board name' do
      render_inline(described_class.with_collection(boards, pin:, current_user:))
      expect(page).to have_css '.board-name'
    end

    context 'when current_user is owner' do
      let(:boards) { create_list(:board, 3, user: current_user) }

      it 'renders add or remove button' do
        render_inline(described_class.with_collection(boards, pin:, current_user:))
        expect(page).to have_css '.btn_1'
      end

      context 'navigation arrow' do
        before do
          create_list(:board_section, 3, board: boards.first)
        end

        it 'renders when it has board sections and active' do
          render_inline(described_class.with_collection(boards, pin:, current_user:, board_section_button: true))
          expect(page).to have_css 'i.angle-navigation-button'
        end

        it 'not renders when it has board sections and deactive' do
          render_inline(described_class.with_collection(boards, pin:, current_user:, board_section_button: false))
          expect(page).not_to have_css 'i.angle-navigation-button'
        end
      end
    end
  end
end
