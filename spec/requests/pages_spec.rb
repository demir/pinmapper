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

  describe 'GET about_us' do
    it 'returns http success' do
      get about_us_url, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET cookie_policy' do
    it 'returns http success' do
      get cookie_policy_url, headers: headers
      expect(response).to have_http_status(:success)
    end
  end
