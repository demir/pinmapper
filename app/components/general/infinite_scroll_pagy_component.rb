# frozen_string_literal: true

module General
  class InfiniteScrollPagyComponent < ViewComponent::Base
    include Turbo::StreamsHelper
    include Pagy::Frontend
    attr_reader :pagy, :record, :records, :format

    def initialize(pagy:, record: nil, records: nil, format: :html)
      @pagy = pagy
      @format = format
      @record = record
      @records = records
    end

    def render?
      pagy.present?
    end

    def next_page
      return pagy.next if records.blank?

      records.size < pagy.vars[:items] ? nil : pagy.page + 1
    end
  end
end
