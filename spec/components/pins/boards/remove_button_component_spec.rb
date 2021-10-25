# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::Boards::RemoveButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board) }
  let(:pin) { create(:pin) }

  context 'with current_user' do
    context 'when not added to board' do
      it 'do not show button' do
        render_inline(described_class.new(board: board, pin: pin, current_user: current_user))
        expect(rendered_component).not_to have_css '.btn_1'
      end
    end

    context 'when added to board' do
      before do
        board.pins << pin
        render_inline(described_class.new(board: board, pin: pin, current_user: current_user))
      end

      it 'shows remove button with added text' do
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
end
