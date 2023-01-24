# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardSections::ListItemForPinComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:board_sections) { create_list(:board_section, 10) }
  let(:pin) { create(:pin) }

  context 'when owner is not important' do
    before do
      render_inline(described_class.with_collection(board_sections, pin:, current_user:))
    end

    it 'name' do
      expect(page).to have_css '.name'
    end

    it 'pins count' do
      expect(page).to have_css '.pins-count'
    end

    it 'not renders add or remove button' do
      expect(page).not_to have_css '.btn_1'
    end
  end

  it 'renders add or remove button when owner is current_user' do
    board = create(:board, user: current_user)
    new_board_sections = create_list(:board_section, 10, board:)
    render_inline(described_class.with_collection(new_board_sections, pin:, current_user:))
    expect(page).to have_css '.btn_1'
  end
end
