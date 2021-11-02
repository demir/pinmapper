# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/edit', type: :view do
  let(:user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: user) }

  before do
    assign(:board, board)
  end

  it 'renders the edit board form' do
    render

    assert_select 'form[action=?][method=?]', board_path(board), 'post' do
      assert_select 'input[name=?]', 'board[name]'

      assert_select 'select[name=?]', 'board[privacy]'
    end
  end
end
