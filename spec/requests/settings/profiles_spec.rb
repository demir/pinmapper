# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Settings::Profiles', type: :request do
  let(:current_user) { create(:user, :confirmed) }
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  context 'with sign in' do
    before do
      sign_in(current_user)
    end

    describe 'PUT /update' do
      it 'returns http success' do
        put settings_profiles_update_path(format: :turbo_stream),
            params:  {
              profile: attributes_for(:profile, bio: Faker::Lorem.paragraph_by_chars(number: 160))
            },
            headers: headers
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'without sign in' do
    describe 'PUT /update' do
      it 'returns http success' do
        put settings_profiles_update_path(format: :turbo_stream),
            params:  {
              profile: attributes_for(:profile, bio: Faker::Lorem.paragraph_by_chars(number: 160))
            },
            headers: headers
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
