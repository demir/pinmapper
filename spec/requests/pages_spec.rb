# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  describe 'GET terms_of_use' do
    it 'returns http success' do
      get terms_of_use_url, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET privacy_policy' do
    it 'returns http success' do
      get privacy_policy_url, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET about' do
    it 'returns http success' do
      get about_url, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET cookie_policy' do
    it 'returns http success' do
      get cookie_policy_url, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /robots.txt' do
    before do
      get '/robots.txt'
    end

    it 'has proper text' do
      expect(response.body).to include('User-agent: *')
    end

    it 'has sitemap text' do
      expect(response.body).to include("Sitemap: #{Rails.application.credentials.domain}/sitemap-index.xml")
    end
  end
end
