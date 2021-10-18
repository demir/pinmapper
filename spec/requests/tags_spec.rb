# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  let(:user) { create(:user, :confirmed) }
  let(:tag) { create(:tag) }

  describe 'specs without sign in' do
    context 'GET /show' do
      it 'returns http success' do
        get tag_path(id: tag)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'specs with sign in' do
    before do
      sign_in(user)
    end

    context 'GET /show' do
      it 'returns http success' do
        get tag_path(id: tag)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
