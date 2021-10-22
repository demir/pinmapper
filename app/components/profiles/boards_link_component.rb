# frozen_string_literal: true

class Profiles::BoardsLinkComponent < ViewComponent::Base
  include Turbo::FramesHelper
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def render?
    user.present?
  end
end
