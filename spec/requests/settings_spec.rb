# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Settings', type: :request do
  describe 'GET /password' do
    it 'returns http success' do
      get '/settings/password'
      expect(response).to have_http_status(:success)
    end
  end
end
