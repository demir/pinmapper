module FollowServices
  class FollowUser < ApplicationService
    attr_reader :follower, :following

    def initialize(follower, following)
      @follower = follower
      @following = following
    end

    def call
      relationship = follower.following_relationships.create!(following: following)
    rescue StandardError => e
      OpenStruct.new({ success?: false, error: e })
    else
      OpenStruct.new({ success?: true, payload: relationship })
    end
  end
end
