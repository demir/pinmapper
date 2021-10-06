# frozen_string_literal: true

class Profiles::FollowUserListItemComponent < ViewComponent::Base
  with_collection_parameter :user
  attr_reader :user, :current_user

  def initialize(user:, current_user:)
    @user = user
    @current_user = current_user
  end
end
