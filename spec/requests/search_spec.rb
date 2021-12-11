# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  describe 'GET /pins' do
    it 'returns http success' do
      get '/search/pins', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /boards' do
    it 'returns http success' do
      get '/search/boards', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users' do
    it 'returns http success' do
      get '/search/users', headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
