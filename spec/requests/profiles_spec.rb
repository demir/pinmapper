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

    context 'GET /follow' do
      it 'returns http fail' do
        get follow_profile_path(id: current_user, format: :turbo_stream)
        expect(response).not_to have_http_status(:success)
      end
    end

    context 'GET /unfollow' do
      it 'returns http fail' do
        user = create(:user, :confirmed)
        FollowServices::FollowUser.call(current_user, user)
        get unfollow_profile_path(id: user, format: :turbo_stream)
        expect(response).not_to have_http_status(:success)
      end
    end

    context 'GET /followers' do
      it 'returns http success' do
        get followers_profile_path(id: current_user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET /following' do
      it 'returns http success' do
        get following_profile_path(id: current_user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET /boards' do
      it 'returns http success' do
        get boards_profile_path(id: current_user)
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

    context 'GET /follow' do
      it 'returns http success' do
        get follow_profile_path(id: current_user, format: :turbo_stream)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET /unfollow' do
      it 'returns http success' do
        user = create(:user, :confirmed)
        FollowServices::FollowUser.call(current_user, user)
        get unfollow_profile_path(id: user, format: :turbo_stream)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET /followers' do
      it 'returns http success' do
        get followers_profile_path(id: current_user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET /following' do
      it 'returns http success' do
        get following_profile_path(id: current_user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET /boards' do
      it 'returns http success' do
        get boards_profile_path(id: current_user)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
