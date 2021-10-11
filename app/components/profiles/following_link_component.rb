# frozen_string_literal: true

class Profiles::FollowingLinkComponent < ViewComponent::Base
  include Turbo::FramesHelper
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def render?
    user.present?
  end
end
