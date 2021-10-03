# frozen_string_literal: true

module Profiles
  class FollowersLinkComponent < ViewComponent::Base
    include Turbo::FramesHelper

    def initialize(user:)
      @user = user
    end

    def render?
      @user.present?
    end
  end
end
