# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:current_user) { create(:user, :confirmed) }

  describe 'specs without sign in' do
    context 'GET /show' do
      it 'returns http success' do
        get profile_path(id: current_user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'specs with sign in' do
    before do
      sign_in(current_user)
    end

    context 'GET /show' do
      it 'returns http success' do
        get profile_path(id: current_user)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
