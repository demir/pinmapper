# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  let(:user) { create(:user, :confirmed) }
  let(:tag) { create(:tag) }
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  describe 'specs without sign in' do
    context 'GET /show' do
      it 'returns http success' do
        get tag_path(id: tag), headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    it 'can not GET /following_tags' do
      get following_tags_tags_path, headers: headers
      expect(response).not_to be_successful
    end
  end

  describe 'specs with sign in' do
    before do
      sign_in(user)
    end

    context 'GET /show' do
      it 'returns http success' do
        get tag_path(id: tag), headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    it 'GET /following_tags' do
      get following_tags_tags_path, headers: headers
      expect(response).to be_successful
    end
  end
end
