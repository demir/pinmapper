# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::Boards::AddRemoveButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }
  let(:pin) { create(:pin) }

  context 'with current_user' do
    before do
      render_inline(described_class.new(board: board, pin: pin, current_user: current_user))
    end

    context 'when not added to board' do
      it 'shows button' do
        render_inline(described_class.new(board: board, pin: pin, current_user: current_user))
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('add')
      end
    end

    context 'when added to board' do
      before do
        board.pins << pin
        render_inline(described_class.new(board: board, pin: pin, current_user: current_user))
      end

      it 'do not show button' do
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('added')
      end
    end
  end

  context 'without current_user' do
    before do
      render_inline(described_class.new(board: board, pin: pin, current_user: nil))
    end

    it 'do not show button' do
      expect(rendered_component).not_to have_css '.btn_1'
    end
  end

  context 'when user not owner of board' do
    before do
      board.update(user: create(:user, :confirmed))
      render_inline(described_class.new(board: board, pin: pin, current_user: current_user))
    end

    it 'do not show button' do
      expect(rendered_component).not_to have_css '.btn_1'
    end
  end
end
