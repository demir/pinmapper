# frozen_string_literal: true

module General
  class MapComponent < ViewComponent::Base
    attr_reader :markers

    def initialize(markers:)
      @markers = markers
    end
  end
end
