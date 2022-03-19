# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :system, js: true do
  context 'page titles' do
    let(:keyword) { 'keyword' }

    it '#boards' do
      visit search_boards_path(q: keyword)
      expect(page.title).to include I18n.t('search.title', keyword: keyword)
    end

    it '#pins' do
      visit search_pins_path(q: keyword)
      expect(page.title).to include I18n.t('search.title', keyword: keyword)
    end

    it '#users' do
      visit search_users_path(q: keyword)
      expect(page.title).to include I18n.t('search.title', keyword: keyword)
    end
  end

  it 'search pins' do
    pins = create_list(:pin, 3)
    visit root_path
    keyword = pins.first.name
    fill_in 'q', with: keyword
    find('header .search .icon_search').click
    expect(page).to have_css '.search .col-lg-9.search-main .body .pin > .body h3', text: keyword, exact_text: true
  end

  it 'search users' do
    users = create_list(:user, 3)
    visit root_path
    keyword = users.first.username
    fill_in 'q', with: keyword
    find('header .search .icon_search').click
    click_link I18n.t('search.users')
    expect(page).to have_css '.search .col-lg-9.search-main .body .follow-user-list-item .user .username',
                             text: keyword, exact_text: true
  end

  describe 'search boards' do
    let(:current_user) { create(:user, :confirmed) }

    before do
      sign_in(current_user)
    end

    context 'board owner signed in' do
      it 'search boards' do
        public_board = create(:board, name: 'pinmapper board', privacy: 'public', user: current_user)
        create(:board, name: 'pinmapper board', privacy: 'secret', user: current_user)
        visit root_path
        keyword = public_board.name
        fill_in 'q', with: keyword
        find('header .search .icon_search').click
        click_link I18n.t('search.boards')
        expect(page).to have_css '.search .col-lg-9.search-main .body .board .board-name',
                                 text: keyword, exact_text: true, count: 2
      end
    end

    context 'user not owner of board' do
      let(:user) { create(:user, :confirmed) }

      it 'search boards' do
        public_board = create(:board, name: 'pinmapper board', privacy: 'public', user: user)
        create(:board, name: 'pinmapper board', privacy: 'secret', user: user)
        visit root_path
        keyword = public_board.name
        fill_in 'q', with: keyword
        find('header .search .icon_search').click
        click_link I18n.t('search.boards')
        expect(page).to have_css '.search .col-lg-9.search-main .body .board .board-name',
                                 text: keyword, exact_text: true, count: 1
      end
    end
  end
end
