# frozen_string_literal: true

module General
  class InfiniteScrollPagyComponent < ViewComponent::Base
    include Turbo::StreamsHelper
    include Pagy::Frontend
    attr_reader :pagy, :record, :format

    def initialize(pagy:, record: nil, format: :html)
      @pagy = pagy
      @format = format
      @record = record
    end

    def render?
      pagy.present?
    end
  end
end
