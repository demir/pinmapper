# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!

  def change_password; end

  def change_username; end

  def change_email; end

  def edit_profile; end

  def switch_locale
    current_user.update(locale: params[:locale])
    url = URI(request&.referer || '').path
    url_params = Rails.application.routes.recognize_path(url)
    redirect_to url_params.merge({ locale: params[:locale] })
  end
end
