# frozen_string_literal: true

module Taggable
  class TagListComponent < ViewComponent::Base
    attr_reader :tags

    def initialize(tags:)
      @tags = tags
    end
  end
end
