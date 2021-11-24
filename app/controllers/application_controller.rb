# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  around_action :switch_locale
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?

  def switch_locale(&action)
    locale_from_header = extract_locale_from_accept_language_header
    locale = params[:locale] || cookies[:locale] || locale_from_header || I18n.default_locale
    cookies[:locale] = locale
    I18n.with_locale(locale, &action)
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def user_not_authorized
    flash[:alert] = I18n.t('user_not_authorized')
    redirect_to(request.referer || root_path)
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first&.to_sym
  end
end
