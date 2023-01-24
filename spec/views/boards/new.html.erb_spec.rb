# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/new', type: :view do
  before do
    user = create(:user, :confirmed)
    assign(:board, build(:board, user:))
  end

  it 'renders new board form' do
    render

    assert_select 'form[action=?][method=?]', boards_path, 'post' do
      assert_select 'input[name=?]', 'board[name]'

      assert_select 'input[name=?]', 'board[description]'

      assert_select 'select[name=?]', 'board[privacy]'
    end
  end
end
