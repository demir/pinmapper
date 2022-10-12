# frozen_string_literal: true

class EmbedsController < ApplicationController
  before_action :authorize_embed
  before_action :set_embed

  def update
    if @embed.present?
      content = ApplicationController.render(partial: 'embeds/thumbnail',
                                             locals:  { embed: @embed },
                                             formats: :html)
      render json: { content:, sgid: @embed.attachable_sgid }
    else
      render json: { content: '', sgid: '' }
    end
  end

  private

  def set_embed
    @embed = Embed.find_by(url: params[:content])
    if @embed.blank?
      begin
        @embed = Embed.create(url: params[:content])
      rescue StandardError
        @embed = nil
      end
    elsif @embed.thumbnail_url != @embed.oembed.thumbnail_url
      @embed.update(thumbnail_url: @embed.oembed.thumbnail_url)
    end
  end

  def authorize_embed
    authorize Embed
  end
end
