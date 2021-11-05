# frozen_string_literal: true

module Settings
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def change_password
      respond_to do |format|
        if current_user.update_with_password(change_password_params)
          bypass_sign_in(current_user)
          flash.now[:notice] = t('.password_changed')
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('change_password_form', partial: 'settings/change_password_form'),
              turbo_stream.update('toastr', partial: 'shared/toastr', formats: [:turbo_stream])
            ]
          end
        else
          format.html { render 'settings/change_password', status: :unprocessable_entity }
        end
      end
    end

    def change_username
      respond_to do |format|
        if current_user.update(change_username_params)
          flash.now[:notice] = t('.username_changed')
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('change_username_form', partial: 'settings/change_username_form'),
              turbo_stream.update('toastr', partial: 'shared/toastr', formats: [:turbo_stream])
            ]
          end
        else
          format.html { render 'settings/change_username', status: :unprocessable_entity }
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    def change_password_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

    def change_username_params
      params.require(:user).permit(:username)
    end
  end
end
