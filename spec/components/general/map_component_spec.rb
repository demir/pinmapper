# frozen_string_literal: true

require 'rails_helper'

RSpec.describe General::MapComponent, type: :component do
  let(:pins_array) { create_list(:pin, 2) }
  let(:pins) { Pin.where(id: pins_array.pluck(:id)) }
  let(:marker_service) { MapServices::GenerateMarkers::Pin.call(pins) }

  before do
    render_inline(described_class.new(markers: marker_service[:payload]))
  end

  context 'div.map' do
    it 'data-controller' do
      expect(rendered_component).to have_css 'div[data-controller="map"]'
    end

    it 'data-makers-value' do
      expect(rendered_component).to have_css 'div[data-map-markers-value]'
    end

    it 'data-access-token-value' do
      expect(rendered_component).to(
        have_css("div[data-map-access-token-value='#{Rails.application.credentials.dig(:mapbox, :access_token)}']")
      )
    end

    it 'data-target-map-container' do
      expect(rendered_component).to(
        have_css('div[data-map-target="container"]')
      )
    end
  end
end
