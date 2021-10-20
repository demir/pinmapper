# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_locale
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_locale
    I18n.locale = params[:locale] || cookies[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
    cookies[:locale] = I18n.locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge(options)
  end

  def user_not_authorized
    flash[:alert] = I18n.t('user_not_authorized')
    redirect_to(request.referer || root_path)
  end
end
