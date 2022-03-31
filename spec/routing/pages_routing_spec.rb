# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  describe 'routing' do
    it 'routes to #terms_of_use' do
      expect(get: '/terms_of_use').to route_to('pages#terms_of_use')
    end

    it 'routes to #privacy_policy' do
      expect(get: '/privacy_policy').to route_to('pages#privacy_policy')
    end

    it 'routes to #about_us' do
      expect(get: '/about_us').to route_to('pages#about_us')
    end

    it 'routes to #cookie_policy' do
      expect(get: '/cookie_policy').to route_to('pages#cookie_policy')
    end
  end
end
