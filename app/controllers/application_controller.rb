# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || cookies[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
    cookies[:locale] = I18n.locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge(options)
  end
end
