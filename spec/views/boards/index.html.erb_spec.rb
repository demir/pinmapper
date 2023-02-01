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
  end

  context 'with any board' do
    before do
      render
    end

    it 'renders title' do
      assert_select '.boards > .header .title h1', text: t('boards.boards')
    end

    it 'renders boards count' do
      assert_select '.boards > .header .title .count', text: "(#{boards.count})"
    end

    it 'renders a list of boards' do
      assert_select '.board .general-more .dropdown-item:nth-of-type(1)', text: t('edit'), count: 2
      assert_select '.board span > a.black-link', count: 2
      assert_select '.board .badge.privacy', count: 2
    end
  end

  context 'without any board' do
    it 'shows no data message' do
      assign(:boards, [])
      render
      assert_select '.board span > a.black-link', count: 0
      assert_select '.no-data p', text: I18n.t('boards.index.no_data_for_current_user'), count: 1
    end
  end

  context 'drag sort' do
    it 'drag sort controller' do
      render
      assert_select '.body #infinite-boards[data-controller="drag-sort"]'
    end

    it 'active' do
      render
      assert_select '.body #infinite-boards[data-drag-sort-state-value="true"]'
    end
  end
end
