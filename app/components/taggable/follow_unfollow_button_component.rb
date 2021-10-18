# frozen_string_literal: true

module Taggable
  class FollowUnfollowButtonComponent < ViewComponent::Base
    include Turbo::FramesHelper
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
