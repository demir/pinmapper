# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Settings', type: :request do
  let(:current_user) { create(:user, :confirmed) }

  context 'with sign in' do
    before do
      sign_in(current_user)
    end

    describe 'GET /password' do
      it 'returns http success' do
        get settings_change_password_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'without sign in' do
    describe 'GET /password' do
      it 'returns http success' do
        get settings_change_password_path
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end