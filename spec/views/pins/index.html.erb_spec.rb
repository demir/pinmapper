# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/index', type: :view do
  let(:user) { create(:user, :confirmed) }
  let(:pins) do
    pin_attributes = attributes_for(:pin, user_id: user.id)
    create_list(:pin, 2, pin_attributes)
  end

  before do
    assign(:pins, pins)
  end

  context 'specs with current_user' do
    it 'renders a list of pins' do
      sign_in(user)
      render
      pin = pins.first
      assert_select '.pin .header .dropdown-item:nth-of-type(1)', text: t('edit'), count: 2
      assert_select '.pin .user span', text: pin.user.email, count: 2
      assert_select '.pin .body h3', text: pin.name, count: 2
      assert_select '.pin .body .cover-image-description', text: pin.cover_image_description, count: 2
      assert_select '.pin .body a.pin-tag:nth-of-type(1)', text: "##{pin.tag_list.first}", count: 2
      assert_select '.pin .body .time-ago', text: "#{time_ago_in_words(pin.created_at)} #{t('ago')}", count: 2
      assert_select 'a[class=?]', 'like_btn'
    end
  end

  context 'specs without current_user' do
    it 'renders a list of pins' do
      render
      pin = pins.first
      assert_select '.pin .header .dropdown-item:nth-of-type(1)', count: 0
      assert_select '.pin .user span', text: pin.user.email, count: 2
      assert_select '.pin .body h3', text: pin.name, count: 2
      assert_select '.pin .body .cover-image-description', text: pin.cover_image_description, count: 2
      assert_select '.pin .body a.pin-tag:nth-of-type(1)', text: "##{pin.tag_list.first}", count: 2
      assert_select '.pin .body .time-ago', text: "#{time_ago_in_words(pin.created_at)} #{t('ago')}", count: 2
      assert_select 'a[class=?]', 'like_btn'
    end
  end
end
