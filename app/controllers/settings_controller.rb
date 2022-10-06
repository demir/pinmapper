# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!

  def change_password; end

  def change_username; end

  def change_email; end

  def edit_profile; end

  def switch_locale
    current_user.update(locale: params[:locale])
    I18n.locale = params[:locale]
    redirect_to handle_url
  end

  def accept_cookies
    current_user.cookies_confirmation_status_accepted! if current_user.present?

    head :ok
  end

  private

  def start_with_available_locales_regex(available_locales)
    locales = available_locales.join('|')
    Regexp.new("\\A#{locales}")
  end

  def handle_url
    url = URI(request&.referer || '').path
    only_locales = I18n.available_locales.map { |l| "/#{l}" }
    url = "#{url}/" if only_locales.include?(url)
    available_locales = I18n.available_locales.map { |l| "/#{l}/" }
    if url.start_with?(*available_locales)
      url = url.sub(start_with_available_locales_regex(available_locales), "/#{params[:locale]}/")
    end
    url
  end
end
