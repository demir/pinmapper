# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :routing do
  describe 'routing' do
    it 'routes to #pins' do
      expect(get: '/search/pins').to route_to('search#pins')
    end

    it 'routes to #boards' do
      expect(get: '/search/boards').to route_to('search#boards')
    end

    it 'routes to #users' do
      expect(get: '/search/users').to route_to('search#users')
    end
  end
end
