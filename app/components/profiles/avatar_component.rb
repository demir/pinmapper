# frozen_string_literal: true

module Profiles
  class AvatarComponent < ViewComponent::Base
    attr_reader :src, :alt, :size, :klass, :display

    def initialize(src:, alt: 'avatar', size: 40, klass: '', display: true)
      @src = src
      @alt = alt
      @size = size
      @klass = klass
      @display = display
    end

    def render?
      display
    end

    def before_render
      @src = helpers.asset_pack_path('media/images/avatar.jpg') if @src.blank?
    end
  end
end
