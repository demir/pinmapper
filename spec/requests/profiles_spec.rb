# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:user) { create(:user, :confirmed) }

  describe 'GET /show' do
    it 'returns http success' do
      get profile_path(id: user)
      expect(response).to have_http_status(:success)
    end
  end
end
