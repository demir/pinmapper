# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'explore/location', type: :view do
  include Pagy::Backend
  let(:user) { create(:user, :confirmed) }
  let(:pins) { create_list(:pin, 2) }
  let(:pin) { pins.first }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    assign(:pin, pin)
    assign(:pins, pins)
    assign(:pagy, pagy_obj)
    render
  end

  context 'elements' do
    it '#map' do
      expect(rendered).to have_css '.location .map[data-map-target="container"]'
    end

    it '#title' do
      expect(rendered).to have_css '.location .title', text: pin.address
    end

    it '#pins' do
      expect(rendered).to have_css '.location .infinite-pins .pin', count: 2
    end
  end
end
