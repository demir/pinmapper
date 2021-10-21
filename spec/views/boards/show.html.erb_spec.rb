# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/show', type: :view do
  Board.destroy_all
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }

  before do
    assign(:board, board)
  end

  context 'renders attributes of board' do
    before do
      render
    end

    it '#name' do
      expect(rendered).to match(/#{board.name}/)
    end

    it '#user.privacy' do
      expect(rendered).to match(/#{board.translated_privacy}/)
    end
  end
end
