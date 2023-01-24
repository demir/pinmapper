# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::BoardSections::AddRemoveButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }
  let(:board_section) { create(:board_section, board:) }
  let(:pin) { create(:pin) }

  context 'with current_user' do
    before do
      render_inline(described_class.new(board_section:, pin:, current_user:))
    end

    context 'when not added to board' do
      it 'shows button' do
        render_inline(described_class.new(board_section:, pin:, current_user:))
        expect(page).to have_css '.btn_1', text: I18n.t('add')
      end
    end

    context 'when added to board section' do
      before do
        board_section.pins << pin
        render_inline(described_class.new(board_section:, pin:, current_user:))
      end

      it 'do not show button' do
        expect(page).to have_css '.btn_1', text: I18n.t('added')
      end
    end
  end

  context 'without current_user' do
    before do
      render_inline(described_class.new(board_section:, pin:, current_user: nil))
    end

    it 'do not show button' do
      expect(page).not_to have_css '.btn_1'
    end
  end

  context 'when user not owner of board section' do
    before do
      board.update(user: create(:user, :confirmed))
      render_inline(described_class.new(board_section:, pin:, current_user:))
    end

    it 'do not show button' do
      expect(page).not_to have_css '.btn_1'
    end
  end
end
