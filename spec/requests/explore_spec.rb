# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Explore', type: :request do
  let(:user) { create(:user, :confirmed) }
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  context 'specs without sign in' do
    describe 'GET /index' do
      it 'renders a successful response' do
        get explore_index_url, headers: headers
        expect(response).to be_successful
      end
    end
  end

  context 'specs with sign in' do
    before do
      sign_in(user)
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        get explore_index_url, headers: headers
        expect(response).to be_successful
      end
    end
  end
end
