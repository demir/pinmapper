# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!

  def password; end
end
