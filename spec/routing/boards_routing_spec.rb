# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/boards').to route_to('boards#index')
    end

    it 'routes to #new' do
      expect(get: '/boards/new').to route_to('boards#new')
    end

    it 'routes to #show' do
      expect(get: '/boards/1').to route_to('boards#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/boards/1/edit').to route_to('boards#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/boards').to route_to('boards#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/boards/1').to route_to('boards#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/boards/1').to route_to('boards#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/boards/1').to route_to('boards#destroy', id: '1')
    end

    it 'routes to #add_pin' do
      expect(get: '/boards/1/add_pin/2').to route_to('boards#add_pin', id: '1', pin_id: '2')
    end

    it 'routes to #remove_pin' do
      expect(get: '/boards/1/remove_pin/2').to route_to('boards#remove_pin', id: '1', pin_id: '2')
    end

    it 'routes to #add_to_board_list' do
      expect(get: '/boards/add_to_board_list/1').to route_to('boards#add_to_board_list', pin_id: '1')
    end

    it 'routes to #follow' do
      expect(get: '/boards/1/follow').to route_to('boards#follow', id: '1')
    end

    it 'routes to #unfollow' do
      expect(get: '/boards/1/unfollow').to route_to('boards#unfollow', id: '1')
    end

    it 'routes to #following_boards' do
      expect(get: '/boards/following_boards').to route_to('boards#following_boards')
    end
  end
end
