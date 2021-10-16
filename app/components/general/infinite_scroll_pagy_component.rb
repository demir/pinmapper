# frozen_string_literal: true

module General
  class InfiniteScrollPagyComponent < ViewComponent::Base
    include Turbo::StreamsHelper
    include Pagy::Frontend
    attr_reader :pagy, :format

    def initialize(pagy:, format: :html)
      @pagy = pagy
      @format = format
    end

    def render?
      pagy.present?
    end
  end
end
