# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Settings::ProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #update' do
      expect(put: '/settings/profiles/update').to route_to('settings/profiles#update')
    end
  end
end
