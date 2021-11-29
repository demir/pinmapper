# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
    skip_before_action :verify_authenticity_token, only: :google_oauth2

    # rubocop:disable Metrics/AbcSize
    def google_oauth2
      response = OmniauthServices::Google.call(request.env['omniauth.auth'])
      @user = response[:payload] if response[:success]
      if @user&.persisted?
        sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        # Removing extra as it can overflow some session stores
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
        redirect_to new_user_registration_url
      end
    end
    # rubocop:enable Metrics/AbcSize

    def failure
      redirect_to root_path
    end
  end
end
