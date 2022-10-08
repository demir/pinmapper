class Embed < ApplicationRecord
  include ActionText::Attachable
  require 'oembed'

  after_create :setup
  def setup
    resource = oembed
    self.video = resource.video?
    self.thumbnail_url = resource.thumbnail_url if resource.video?
    self.html = resource.html
    save
  end

  def oembed
    OEmbed::Providers.register_all
    OEmbed::Providers.get(url, { width: '500px' })
  end

  def to_trix_content_attachment_partial_path
    'embeds/thumbnail'
  end
end
