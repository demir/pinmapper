# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::Boards::AddedByOwnerComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: current_user) }
  let(:board1) { create(:board, user: current_user) }
  let(:board2) { create(:board, user: current_user) }

  before do
    render_inline(described_class.new(pin: pin, current_user: current_user))
  end

  context 'when not added to any board' do
    before do
      render_inline(described_class.new(pin: pin, current_user: current_user))
    end

    it 'show added by owner message' do
      expect(rendered_component).not_to have_css '.pin-added-by-owner'
    end
  end

  context 'when added to single board' do
    before do
      board1.pins << pin
      render_inline(described_class.new(pin: pin, current_user: current_user))
    end

    it 'show added by owner message' do
      expect(rendered_component).to have_css '.pin-added-by-owner a.board-link',
                                             text: pin.owner_public_boards.first.name
    end

    it 'not show modal link' do
      expect(rendered_component).not_to have_css '.pin-added-by-owner a.board-link[data-toggle=modal]'
    end
  end

  context 'when added to one more boards' do
    before do
      board1.pins << pin
      board2.pins << pin
      render_inline(described_class.new(pin: pin, current_user: current_user))
    end

    it 'first board' do
      expect(rendered_component).to have_css '.pin-added-by-owner a.board-link',
                                             text: pin.owner_public_boards.first.name
    end

    it 'show modal link' do
      expect(rendered_component).to(
        have_css(".pin-added-by-owner a.board-link[data-target='#pin_boards_added_by_owner_pin_#{pin.id}']")
      )
    end
  end
end
