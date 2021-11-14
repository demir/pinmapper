# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'search/users.html.erb', type: :view do
  include Pagy::Backend
  let(:users) { create_list(:user, 2) }
  let(:pagy_obj) do
    ar_users = User.where(id: users.pluck(:id))
    pagy(ar_users).first
  end

  before do
    assign(:users, users)
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
                  text: I18n.t('search.users'), count: 1
  end

  context 'with users' do
    it 'body user' do
      assert_select '.search .col-lg-9.search-main .body .follow-user-list-item', count: 2
    end
  end

  context 'without users' do
    let(:none_users) { User.none }

    before do
      assign(:users, none_users)
      render
    end

    it 'body no results found' do
      assert_select '.search .col-lg-9.search-main .body .no-results-found', count: 1
    end
  end
end
