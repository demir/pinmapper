class EmbedsController < ApplicationController
  def update
    authorize Embed
    embed = Embed.find_by(url: params[:content])
    if embed.blank?
      begin
        embed = Embed.create(url: params[:content])
      rescue StandardError => e
        render json: { content: '', sgid: '' }
      end
    elsif embed.thumbnail_url != embed.oembed.thumbnail_url
      embed.update(thumbnail_url: embed.oembed.thumbnail_url)
    end
    if embed.present?
      content = ApplicationController.render(partial: 'embeds/thumbnail',
                                             locals:  { embed: },
                                             formats: :html)
      render json: { content:, sgid: embed.attachable_sgid }
    end
  end
end
