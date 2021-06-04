# frozen_string_literal: true

module Pins
  class LikeButtonComponent < ViewComponent::Base
    include Turbo::FramesHelper
    attr_accessor :pin, :current_user

    def initialize(pin:, current_user:)
      @pin = pin
      @current_user = current_user
    end

    def url
      return '#' if current_user.blank?

      current_user.liked?(pin) ? unlike_pin_path(pin) : like_pin_path(pin)
    end

    def klass
      return 'like_btn disabled' if current_user.blank?

      current_user.liked?(pin) ? 'like_btn liked' : 'like_btn'
    end

    def disabled?
      current_user.blank?
    end
  end
end
