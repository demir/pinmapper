# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user
  def show; end

  def follow
    FollowServices::FollowUser.call(current_user, @user)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def unfollow
    FollowServices::UnfollowUser.call(current_user, @user)
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
