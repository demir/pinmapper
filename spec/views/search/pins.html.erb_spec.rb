# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'search/pins.html.erb', type: :view do
  include Pagy::Backend
  let(:pins) { create_list(:pin, 2) }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    assign(:pins, pins)
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
                  text: I18n.t('search.pins'), count: 1
  end

  context 'with pins' do
    it 'body pins' do
      assert_select '.search .col-lg-9.search-main .body .pin', count: 2
    end
  end

  context 'without pins' do
    let(:none_pins) { Pin.none }

    before do
      assign(:pins, none_pins)
      render
    end

    it 'body no results found' do
      assert_select '.search .col-lg-9.search-main .body .no-results-found', count: 1
    end
  end
end
