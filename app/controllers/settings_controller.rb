# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!

  def change_password; end

  def change_username; end
end
