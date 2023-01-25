# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'board_sections/new', type: :view do
  let(:board) { create(:board) }

  before do
    assign(:board, board)
    assign(:board_section, build(:board_section, board:))
  end

  it 'renders new board_section form' do
    render
    assert_select 'form[action=?][method=?]', board_board_sections_path(board, locale: I18n.locale),
                  'post' do
      assert_select 'input[name=?]', 'board_section[name]'
      assert_select 'input[name=?]', 'board_section[description]'
    end
  end
end
