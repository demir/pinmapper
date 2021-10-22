# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/index', type: :view do
  include Pagy::Backend
  let(:user) { create(:user, :confirmed) }
  let(:boards) do
    board_attributes = attributes_for(:board, user_id: user.id)
    create_list(:board, 2, board_attributes)
  end
  let(:pagy_obj) do
    ar_boards = Board.where(id: boards.pluck(:id))
    pagy(ar_boards).first
  end

  before do
    assign(:boards, boards)
    assign(:pagy, pagy_obj)
    sign_in(user)
    render
  end

  it 'renders header' do
    assert_select '.boards > .header #boards-count', text: "#{t('boards.boards')} (#{boards.count})"
  end

  it 'renders a list of boards' do
    assert_select '.board .board-more .dropdown-item:nth-of-type(1)', text: t('edit'), count: 2
    assert_select '.board span > a.black-link', count: 2
    assert_select '.board .badge.privacy', count: 2
  end
end
