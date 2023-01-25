# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'board_sections/edit', type: :view do
  let(:board_section) { create(:board_section) }

  before do
    assign(:board_section, board_section)
  end

  it 'renders the edit board_section form' do
    render

    assert_select 'form[action=?][method=?]', board_section_path(board_section), 'post' do
      assert_select 'input[name=?]', 'board_section[name]'
      assert_select 'input[name=?]', 'board_section[description]'
    end
  end
end
