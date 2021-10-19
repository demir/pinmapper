# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/profiles/1').to route_to('profiles#show', id: '1')
    end

    it 'routes to #follow' do
      expect(get: '/profiles/1/follow').to route_to('profiles#follow', id: '1')
    end

    it 'routes to #unfollow' do
      expect(get: '/profiles/1/unfollow').to route_to('profiles#unfollow', id: '1')
    end

    it 'routes to #followers' do
      expect(get: '/profiles/1/followers').to route_to('profiles#followers', id: '1')
    end

    it 'routes to #following' do
      expect(get: '/profiles/1/following').to route_to('profiles#following', id: '1')
    end
  end
end
