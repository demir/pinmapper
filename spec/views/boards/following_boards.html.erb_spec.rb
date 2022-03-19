# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/following_boards', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:boards) { create_list(:board, 2) }
  let(:pagy_obj) do
    ar_boards = Board.where(id: boards.pluck(:id))
    pagy(ar_boards).first
  end

  before do
    sign_in(current_user)
    current_user.following_boards << boards.first
    current_user.following_boards << boards.second
    assign(:current_user, current_user)
    assign(:boards, boards)
    assign(:pagy, pagy_obj)
  end

  context 'with any board' do
    before do
      render
    end

    it 'renders title' do
      assert_select '.boards > .header .title h1', text: t('boards.following_boards.title')
    end

    it 'renders boards count' do
      assert_select '.boards > .header .title .count', text: "(#{boards.count})"
    end

    it 'renders a list of boards' do
      assert_select '.board .board-more .dropdown-item:nth-of-type(1)', text: t('edit'), count: 0
      assert_select '.board span > a.black-link', count: 2
      assert_select '.board .item a.btn_1', count: 2
    end
  end

  context 'without any board' do
    it 'shows no data message' do
      assign(:boards, [])
      render
      assert_select '.board span > a.black-link', count: 0
      assert_select '.no-data p', text: I18n.t('boards.following_boards.no_data'), count: 1
    end
  end
end
