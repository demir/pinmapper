# frozen_string_literal: true

module Profiles
  class FollowButtonComponent < ViewComponent::Base
    def initialize(user:, current_user: nil)
      @user = user
      @current_user = current_user
    end

    def render?
      return if @current_user.blank?
      return if @current_user == @user

      @current_user.following.exclude?(@user)
    end
  end
end
