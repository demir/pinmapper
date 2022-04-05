# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'explore/index.html.erb', type: :view do
  include Pagy::Backend
  let(:user) { create(:user, :confirmed) }
  let(:pins) { create_list(:pin, 2) }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    assign(:pins, pins)
    assign(:pagy, pagy_obj)
  end

  context 'specs with current_user' do
    it 'renders a list of pins' do
      sign_in(user)
      render
      assert_select '.pin .user .username', count: 2
      assert_select '.pin .body .name-h3', count: 2
      assert_select '.pin .body .cover-photo-description', count: 2
      assert_select '.pin .body .tags a.pin-tag:nth-of-type(1)', count: 2
      assert_select '.pin .header .username-timeago .time-ago', count: 2
      assert_select 'a[class=?]', 'like_btn'
    end
  end

  context 'specs without current_user' do
    it 'renders a list of pins' do
      render
      assert_select '.pin .header .dropdown-item:nth-of-type(1)', count: 0
      assert_select '.pin .user .username', count: 2
      assert_select '.pin .body .name-h3', count: 2
      assert_select '.pin .body .cover-photo-description', count: 2
      assert_select '.pin .body .tags a.pin-tag:nth-of-type(1)', count: 2
      assert_select '.pin .header .username-timeago .time-ago', count: 2
      assert_select 'a[class=?]', 'like_btn disabled'
    end
  end
end
