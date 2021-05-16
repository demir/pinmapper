# frozen_string_literal: true

module Pins
  class TopHeroComponent < ViewComponent::Base
    def initialize(title:)
      @title = title
    end
  end
end
