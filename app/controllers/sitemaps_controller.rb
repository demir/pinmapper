# frozen_string_literal: true

class SitemapsController < ApplicationController
  def show
    if valid_resource_sitemap?
      resource_sitemap(resource_string)
    else
      sitemap_index
    end
    render @view_template, layout: false
  end

  private

  def sitemap_index
    @view_template = 'index'
  end

  # rubocop:disable Metrics/MethodLength
  def resource_sitemap(resource)
    case resource
    when 'pins'
      @pins = Pin.order(updated_at: :desc).pluck(:slug, :updated_at)
    when 'boards'
      @boards = Board.public_privacy.order(updated_at: :desc).pluck(:id, :updated_at)
    when 'users'
      @users = User.order(updated_at: :desc).pluck(:username, :updated_at)
    when 'tags'
      @tags = ActsAsTaggableOn::Tag.order(updated_at: :desc).pluck(:slug, :updated_at)
    end
    @view_template = resource
  end
  # rubocop:enable Metrics/MethodLength

  def valid_resource_sitemap?
    %w[pins boards users tags].include?(resource_string)
  end

  def resource_string
    params[:sitemap].gsub('.xml', '').split('-')[1]
  end
end
