# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Explore', type: :system, js: true do
  it 'initialize leaflet js for map on location' do
    pin = create(:pin)
    visit explore_location_path(pin.token, locale: I18n.locale)
    expect(page).to have_css '.map.leaflet-container .leaflet-layer'
  end
end
