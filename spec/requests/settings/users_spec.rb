# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Settings::Users', type: :request do
  describe 'GET /change_password' do
    it 'returns http success' do
      get '/settings/users/change_password'
      expect(response).to have_http_status(:success)
    end
  end
end
