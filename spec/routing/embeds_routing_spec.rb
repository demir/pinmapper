# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmbedsController, type: :routing do
  let(:embed) { build(:embed, :video) }

  describe 'routing' do
    it 'routes to #update via PUT' do
      expect(put: '/embed').to route_to('embeds#update')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/embed').to route_to('embeds#update')
    end
  end
end
