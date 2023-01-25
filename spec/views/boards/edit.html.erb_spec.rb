# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/edit', type: :view do
  let(:user) { create(:user, :confirmed) }
  let(:board) { create(:board, user:) }

  before do
    assign(:board, board)
  end

  it 'renders the edit board form' do
    render

    assert_select 'form[action=?][method=?]', board.new_record? ? boards_path(pin_id: 1) : board_path(id: board),
                  'post' do
      assert_select 'input[name=?]', 'board[name]'

      assert_select 'input[name=?]', 'board[description]'

      assert_select 'select[name=?]', 'board[privacy]'
    end
  end
end
