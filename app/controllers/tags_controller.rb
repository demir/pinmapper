# frozen_string_literal: true

class TagsController < ApplicationController
  include Pagy::Backend
  before_action :set_tag

  def show
    @pagy, @pins = pagy @tag.pins.order(created_at: :desc)
    respond_to do |f|
      f.turbo_stream
      f.html
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
