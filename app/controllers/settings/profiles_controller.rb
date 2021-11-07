# frozen_string_literal: true

module Settings
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def update
      respond_to do |format|
        if current_user.profile.update(update_profile_params)
          flash.now[:notice] = t('.profile_updated')
          format.turbo_stream
        else
          format.html { render 'settings/edit_profile', status: :unprocessable_entity }
        end
      end
    end

    private

    def update_profile_params
      params.require(:profile)
            .permit(:bio, :avatar,
                    avatar_crop_attributes: %i[crop_x crop_y crop_width crop_height])
    end
  end
end
