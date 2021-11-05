# frozen_string_literal: true

module Settings
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def change_password
      respond_to do |format|
        if current_user.update_with_password(change_password_params)
          sign_in(current_user, bypass: true)
          flash.now[:notice] = t('.password_changed')
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('change_password_form', partial: 'settings/password_form'),
              turbo_stream.update('toastr', partial: 'shared/toastr', formats: [:turbo_stream])
            ]
          end
        else
          format.html { render 'settings/password', status: :unprocessable_entity }
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    def change_password_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end
  end
end
