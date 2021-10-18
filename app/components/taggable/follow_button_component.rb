# frozen_string_literal: true

module Taggable
  class FollowButtonComponent < ViewComponent::Base
    attr_reader :tag, :current_user

    def initialize(tag:, current_user:)
      @tag = tag
      @current_user = current_user
    end

    def render?
      return if current_user.blank?

      current_user.tags.exclude?(tag)
    end
  end
end
