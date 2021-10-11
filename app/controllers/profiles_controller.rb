# frozen_string_literal: true

class ProfilesController < ApplicationController
  include Pagy::Backend
  before_action :set_user
  before_action :set_current_profile, only: %i[follow unfollow]
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

  def followers
    @pagy, @followers = pagy @user.followers
    respond_to do |f|
      f.turbo_stream
      f.html
    end
  end

  def following
    @pagy, @following = pagy @user.following
    respond_to do |f|
      f.turbo_stream
      f.html
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_profile
    referer_params = Rails.application.routes.recognize_path(request.referer)
    user_id = referer_params.fetch(:id, nil)
    @current_profile = user_id.blank? ? nil : User.find(user_id)
  end
end
