# frozen_string_literal: true

module Pins
  class TagListComponent < ViewComponent::Base
    def initialize(tag_list:)
      @tag_list = tag_list
    end
  end
end
