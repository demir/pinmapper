# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/liked_pins', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:pins) { create_list(:pin, 2) }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    sign_in(current_user)
    pins.first.liked_by current_user
    pins.second.liked_by current_user
    assign(:current_user, current_user)
    assign(:pins, pins)
    assign(:pagy, pagy_obj)
  end

  context 'with any pin' do
    before do
      render
    end

    it 'renders title' do
      assert_select '.liked-pins > .header .title h1', text: t('liked_pins')
    end

    it 'renders pins count' do
      assert_select '.liked-pins > .header .title .count', text: "(#{pins.count})"
    end

    it 'renders a list of pins' do
      expect(rendered).to have_css '.pin > .header > .user', count: 2
    end
  end

  context 'without any pin' do
    it 'shows no data message' do
      assign(:pins, [])
      render
      assert_select '.pin .body h3', count: 0
      assert_select '.no-data p', text: I18n.t('pins.liked_pins.no_data'), count: 1
    end
  end
end
