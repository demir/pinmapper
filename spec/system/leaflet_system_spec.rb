# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Leaflet', type: :system, js: true do
  let!(:user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: user) }

  context 'pins map' do
    before do
      pins.second.update(address: 'Rize, Turkey')
      visit profile_path(id: user)
    end

    it 'markers count' do
      expect(page).to have_css '.leaflet-marker-icon', count: 2
    end

    context 'clicked marker' do
      before do
        first('.leaflet-marker-icon').click
      end

      it 'header#title' do
        expect(page).to have_css '.leaflet-popup h3.title a.black-link'
      end

      it '#cover-image-description' do
        expect(page).to have_css '.leaflet-popup p.cover-image-description'
      end

      it '#direction-link' do
        expect(page).to have_css '.leaflet-popup a.btn_infobox_get_directions'
      end
    end
  end
end
