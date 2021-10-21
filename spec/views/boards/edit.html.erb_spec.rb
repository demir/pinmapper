# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/edit', type: :view do
  before do
    @board = assign(:board, Board.create!(
                              name:    'MyString',
                              privacy: 1
                            ))
  end

  it 'renders the edit board form' do
    render

    assert_select 'form[action=?][method=?]', board_path(@board), 'post' do
      assert_select 'input[name=?]', 'board[name]'

      assert_select 'input[name=?]', 'board[privacy]'
    end
  end
end
