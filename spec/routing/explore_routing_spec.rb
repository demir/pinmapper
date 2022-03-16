# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExploreController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/explore/index').to route_to('explore#index')
    end

    it 'routes to #location' do
      expect(get: 'explore/locations/aPzbKPGqsSoqSBuSY6dy5888').to(
        route_to('explore#location', token: 'aPzbKPGqsSoqSBuSY6dy5888')
      )
    end
  end
end
