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

  def follow
    current_user.tags << @tag
    respond_to do |format|
      format.turbo_stream
    end
  end

  def unfollow
    current_user.tags.delete(@tag)
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
