# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Settings::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #change_password' do
      expect(put: '/settings/users/change_password').to route_to('settings/users#change_password')
    end

    it 'routes to #change_username' do
      expect(put: '/settings/users/change_username').to route_to('settings/users#change_username')
    end

    it 'routes to #change_email' do
      expect(put: '/settings/users/change_email').to route_to('settings/users#change_email')
    end
  end
end
