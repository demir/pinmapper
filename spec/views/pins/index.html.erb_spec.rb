# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/index', type: :view do
  include Pagy::Backend
  let(:user) { create(:user, :confirmed) }
  let(:pins) do
    pin_attributes = attributes_for(:pin, user_id: user.id)
    create_list(:pin, 2, pin_attributes)
  end
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
      assert_select '.pin .header .dropdown-item:nth-of-type(1)', text: t('edit'), count: 2
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

  context 'without any pin' do
    it 'shows no data message' do
      assign(:pins, [])
      render
      assert_select '.pin .body h3', count: 0
      assert_select('.empty-message p',
                    text:  I18n.t('pins.index.empty_message', explore_link: I18n.t('explore.explore')),
                    count: 1)
    end
  end
end
