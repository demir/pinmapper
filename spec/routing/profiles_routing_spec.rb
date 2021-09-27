# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/profiles/1').to route_to('profiles#show', id: '1')
    end
  end
end
