# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::Boards::RemoveButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }
  let(:pin) { create(:pin) }

  context 'with current_user' do
    context 'when not added to board' do
      it 'do not show button' do
        render_inline(described_class.new(board:, pin:, current_user:))
        expect(page).not_to have_css '.btn_1'
      end
    end

    context 'when added to board' do
      before do
        board.pins << pin
        render_inline(described_class.new(board:, pin:, current_user:))
      end

      it 'shows remove button with added text' do
        expect(page).to have_css '.btn_1', text: I18n.t('added')
      end
    end
  end

  context 'without current_user' do
    before do
      render_inline(described_class.new(board:, pin:, current_user: nil))
    end

    it 'do not show button' do
      expect(page).not_to have_css '.btn_1'
    end
  end

  context 'when user not owner of board' do
    before do
      board.update(user: create(:user, :confirmed))
      render_inline(described_class.new(board:, pin:, current_user:))
    end

    it 'do not show button' do
      expect(page).not_to have_css '.btn_1'
    end
  end
end
