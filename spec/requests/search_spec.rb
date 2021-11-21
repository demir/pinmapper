# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  describe 'GET /pins' do
    it 'returns http success' do
      get '/search/pins'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /boards' do
    it 'returns http success' do
      get '/search/boards'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users' do
    it 'returns http success' do
      get '/search/users'
      expect(response).to have_http_status(:success)
    end
  end
end
