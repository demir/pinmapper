# frozen_string_literal: true

module Pins
  class TagListComponent < ViewComponent::Base
    attr_reader :tags

    def initialize(tags:)
      @tags = tags
    end
  end
end
