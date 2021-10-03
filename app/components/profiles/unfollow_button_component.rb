# frozen_string_literal: true

module Profiles
  class UnfollowButtonComponent < ViewComponent::Base
    def initialize(user:, current_user:)
      @user = user
      @current_user = current_user
    end

    def render?
      return if @current_user.blank?

      @current_user.following.include?(@user)
    end
  end
end
