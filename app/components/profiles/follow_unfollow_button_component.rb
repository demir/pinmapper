# frozen_string_literal: true

module Profiles
  class FollowUnfollowButtonComponent < ViewComponent::Base
    include Turbo::FramesHelper

    def initialize(user:, current_user:)
      @user = user
      @current_user = current_user
    end

    def render?
      return if @current_user.blank?

      @current_user != @user
    end
  end
end
