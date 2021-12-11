# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  describe 'GET root' do
    it 'returns http success' do
      get root_url, headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
