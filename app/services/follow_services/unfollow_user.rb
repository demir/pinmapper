# frozen_string_literal: true

module FollowServices
  class UnfollowUser < ApplicationService
    attr_reader :follower, :following

    def initialize(follower, following)
      @follower = follower
      @following = following
    end

    def call
      relationship = follower.following_relationships.find_by(following: following).destroy!
    rescue StandardError => e
      { success: false, error: e }
    else
      { success: true, payload: relationship }
    end
  end
end
