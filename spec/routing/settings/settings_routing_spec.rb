# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SettingsController, type: :routing do
  describe 'routing' do
    it 'routes to #change_password' do
      expect(get: '/settings/change_password').to route_to('settings#change_password')
    end

    it 'routes to #change_username' do
      expect(get: '/settings/change_username').to route_to('settings#change_username')
    end

    it 'routes to #change_email' do
      expect(get: '/settings/change_email').to route_to('settings#change_email')
    end

    it 'routes to #edit_profile' do
      expect(get: '/settings/edit_profile').to route_to('settings#edit_profile')
    end

    it 'routes to #switch_locale' do
      expect(get: '/settings/switch_locale').to route_to('settings#switch_locale')
    end

    it 'routes to #accept_cookies' do
      expect(get: '/settings/accept_cookies').to route_to('settings#accept_cookies')
    end
  end
end
