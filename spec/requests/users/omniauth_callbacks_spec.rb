# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::OmniauthCallbacks', type: :request do
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Google' do
    context 'Success handling' do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:default] = create(:auth_hash, :google)
      end

      context "when google_oauth2 email doesn't exist in the system" do
        before do
          post user_google_oauth2_omniauth_callback_path, headers: headers
        end

        let(:user) { User.find_by(email: 'testuser@gmail.com') }

        it 'creates user with info in google_oauth2' do
          expect(user).to be_present
        end

        it 'redirects to root' do
          expect(response).to redirect_to root_path
        end
      end

      context 'when google_oauth2 email already exists in the system' do
        before do
          User.where(email: 'testuser@gmail.com').destroy_all
        end

        it 'signs in and redirects to root' do
          create(:user, :confirmed, email: 'testuser@gmail.com')
          post user_google_oauth2_omniauth_callback_path, headers: headers
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe 'Facebook' do
    context 'Success handling' do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:default] = create(:auth_hash, :facebook)
      end

      context "when facebook email doesn't exist in the system" do
        before do
          post user_facebook_omniauth_callback_path, headers: headers
        end

        let(:user) { User.find_by(email: 'testuser@facebook.com') }

        it 'creates user with info in facebook' do
          expect(user).to be_present
        end

        it 'redirects to root' do
          expect(response).to redirect_to root_path
        end
      end

      context 'when facebook email already exists in the system' do
        before do
          User.where(email: 'testuser@facebook.com').destroy_all
        end

        it 'signs in and redirects to root' do
          create(:user, :confirmed, email: 'testuser@facebook.com')
          post user_facebook_omniauth_callback_path, headers: headers
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
