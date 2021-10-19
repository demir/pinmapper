# frozen_string_literal: true

class TagsController < ApplicationController
  include Pagy::Backend
  before_action :set_tag, except: %i[following_tags]
  before_action :authenticate_user!, except: %i[show]
  before_action :authorize_tag, except: %i[show]

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

  def following_tags
    @pagy, @tags = pagy current_user.tags.order(created_at: :desc)
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def authorize_tag
    authorize @tag || Tag
  end
end
