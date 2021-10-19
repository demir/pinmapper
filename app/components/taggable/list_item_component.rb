# frozen_string_literal: true

module Taggable
  class ListItemComponent < ViewComponent::Base
    with_collection_parameter :tag
    attr_reader :current_user

    def initialize(tag:, current_user:)
      @tag = tag
      @current_user = current_user
    end

    def render?
      current_user.present?
    end
  end
end
