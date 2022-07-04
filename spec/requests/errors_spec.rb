# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /not_found' do
    it 'returns http success' do
      get '404'
      expect(response).to be_successful
    end
  end

  describe 'GET /internal_server_error' do
    it 'returns http success' do
      get '500'
      expect(response).to be_successful
    end
  end
end
