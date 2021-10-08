# frozen_string_literal: true

class General::InfiniteScrollPagyComponent < ViewComponent::Base
  include Turbo::StreamsHelper
  include Pagy::Frontend
  attr_reader :pagy, :format

  def initialize(pagy:, format: :html)
    @pagy = pagy
    @format = format
  end
end
