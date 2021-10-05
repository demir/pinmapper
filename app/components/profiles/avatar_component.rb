# frozen_string_literal: true

module Profiles
  class AvatarComponent < ViewComponent::Base
    attr_reader :src, :alt, :size, :klass, :display

    def initialize(src:, alt: 'avatar', size: 32, klass: '', display: true)
      @src = src
      @alt = alt
      @size = size
      @klass = klass
      @display = display
    end

    def render?
      display
    end
  end
end
