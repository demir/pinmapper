# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PinsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pins').to route_to('pins#index')
    end

    it 'routes to #new' do
      expect(get: '/pins/new').to route_to('pins#new')
    end

    it 'routes to #show' do
      expect(get: '/pins/1').to route_to('pins#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pins/1/edit').to route_to('pins#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pins').to route_to('pins#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pins/1').to route_to('pins#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pins/1').to route_to('pins#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pins/1').to route_to('pins#destroy', id: '1')
    end

    it 'routes to #like' do
      expect(get: '/pins/1/like').to route_to('pins#like', id: '1')
    end

    it 'routes to #unlike' do
      expect(get: '/pins/1/unlike').to route_to('pins#unlike', id: '1')
    end

    it 'routes to #liked_pins' do
      expect(get: '/pins/liked_pins').to route_to('pins#liked_pins')
    end
  end
end
