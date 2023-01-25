# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardSectionsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      board = create(:board)
      expect(get: "/boards/#{board.name}/board_sections/new").to route_to('board_sections#new', board_id: board.name)
    end

    it 'routes to #show' do
      expect(get: '/board_sections/1').to route_to('board_sections#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/board_sections/1/edit').to route_to('board_sections#edit', id: '1')
    end

    it 'routes to #create' do
      board = create(:board)
      expect(post: "/boards/#{board.name}/board_sections").to route_to('board_sections#create', board_id: board.name)
    end

    it 'routes to #update via PUT' do
      expect(put: '/board_sections/1').to route_to('board_sections#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/board_sections/1').to route_to('board_sections#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/board_sections/1').to route_to('board_sections#destroy', id: '1')
    end

    it 'routes to #add_pin' do
      expect(get: '/board_sections/1/add_pin/2').to route_to('board_sections#add_pin', id: '1', pin_id: '2')
    end

    it 'routes to #remove_pin' do
      expect(get: '/board_sections/1/remove_pin/2').to route_to('board_sections#remove_pin', id: '1', pin_id: '2')
    end

    it 'routes to #move' do
      expect(patch: '/board_sections/1/move').to route_to('board_sections#move', id: '1')
    end

    it 'routes to #move_pin' do
      expect(patch: '/board_sections/1/move_pin/2').to route_to('board_sections#move_pin', id: '1', pin_id: '2')
    end

    it 'routes to #select_board_sections' do
      expect(get: '/board_sections/1/select_board_sections').to route_to('board_sections#select_board_sections',
                                                                         id: '1')
    end

    it 'routes to #autocomplete' do
      expect(get: '/board_sections/1/autocomplete').to route_to('board_sections#autocomplete', id: '1')
    end

    it 'routes to #merge' do
      expect(get: '/board_sections/1/merge').to route_to('board_sections#merge', id: '1')
    end
  end
end
