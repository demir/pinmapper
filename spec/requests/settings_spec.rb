# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Settings', type: :request do
  let(:current_user) { create(:user, :confirmed) }
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  context 'with sign in' do
    before do
      sign_in(current_user)
    end

    describe 'GET /change_password' do
      it 'returns http success' do
        get settings_change_password_path, headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /change_username' do
      it 'returns http success' do
        get settings_change_username_path, headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /change_email' do
      it 'returns http success' do
        get settings_change_email_path, headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /edit_profile' do
      it 'returns http success' do
        get settings_edit_profile_path, headers: headers
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'without sign in' do
    describe 'GET /change_password' do
      it 'returns http success' do
        get settings_change_password_path, headers: headers
        expect(response).not_to have_http_status(:success)
      end
    end

    describe 'GET /change_username' do
      it 'returns http success' do
        get settings_change_username_path, headers: headers
        expect(response).not_to have_http_status(:success)
      end
    end

    describe 'GET /change_email' do
      it 'returns http success' do
        get settings_change_email_path, headers: headers
        expect(response).not_to have_http_status(:success)
      end
    end

    describe 'GET /edit_profile' do
      it 'returns http success' do
        get settings_edit_profile_path, headers: headers
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
