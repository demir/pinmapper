# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'search/boards.html.erb', type: :view do
  include Pagy::Backend
  let(:boards) { create_list(:board, 2) }
  let(:pagy_obj) do
    ar_boards = Board.where(id: boards.pluck(:id))
    pagy(ar_boards).first
  end

  before do
    assign(:boards, boards)
    assign(:pagy, pagy_obj)
    render
  end

  it '.search' do
    assert_select '.search', count: 1
  end

  it 'search results title' do
    assert_select '.search .title .main_title_3 h2', text: I18n.t('search.results'), count: 1
  end

  it 'sidemenu items count' do
    assert_select '.search .row .col-lg-3.search-sidemenu .list-group-item-action', count: 3
  end

  it 'sidemenu active item' do
    assert_select '.search .row .col-lg-3.search-sidemenu .list-group-item-action.active',
                  text: I18n.t('search.boards'), count: 1
  end

  context 'with boards' do
    it 'body board' do
      assert_select '.search .col-lg-9.search-main .body .board', count: 2
    end
  end

  context 'without boards' do
    let(:none_boards) { Board.none }

    before do
      assign(:boards, none_boards)
      render
    end

    it 'body no results found' do
      assert_select '.search .col-lg-9.search-main .body .no-results-found', count: 1
    end
  end
end
