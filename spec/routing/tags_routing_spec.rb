# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/tags/1').to route_to('tags#show', id: '1')
    end

    it 'routes to #follow' do
      expect(get: '/tags/1/follow').to route_to('tags#follow', id: '1')
    end

    it 'routes to #unfollow' do
      expect(get: '/tags/1/unfollow').to route_to('tags#unfollow', id: '1')
    end

    it 'routes to #following_tags' do
      expect(get: '/tags/following_tags').to route_to('tags#following_tags')
    end
  end
end
