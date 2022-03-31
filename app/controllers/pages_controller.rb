# frozen_string_literal: true

class PagesController < ApplicationController
  def about_us; end

  def terms_of_use; end

  def privacy_policy; end

  def cookie_policy; end

  def robots
    respond_to :text
  end
end
