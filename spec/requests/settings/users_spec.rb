# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Settings::Users', type: :request do
  let(:current_user) { create(:user, :confirmed) }

  context 'with sign in' do
    before do
      sign_in(current_user)
    end

    describe 'PUT /change_password' do
      it 'returns http success' do
        put settings_users_change_password_path(format: :turbo_stream),
            params: { user: attributes_for(:user, current_password: '123456') }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PUT /change_username' do
      it 'returns http success' do
        put settings_users_change_username_path(format: :turbo_stream),
            params: { user: attributes_for(:user, username: SecureRandom.hex(15)) }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PUT /change_email' do
      it 'returns http success' do
        put settings_users_change_email_path(format: :turbo_stream),
            params: { user: attributes_for(:user, email: Faker::Internet.unique.email) }
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'without sign in' do
    describe 'PUT /change_password' do
      it 'returns http success' do
        put settings_users_change_password_path(format: :turbo_stream),
            params: { user: attributes_for(:user, current_password: '123456') }
        expect(response).not_to have_http_status(:success)
      end
    end

    describe 'PUT /change_username' do
      it 'returns http success' do
        put settings_users_change_username_path(format: :turbo_stream),
            params: { user: attributes_for(:user, username: SecureRandom.hex(15)) }
        expect(response).not_to have_http_status(:success)
      end
    end

    describe 'PUT /change_email' do
      it 'returns http success' do
        put settings_users_change_email_path(format: :turbo_stream),
            params: { user: attributes_for(:user, email: Faker::Internet.unique.email) }
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
