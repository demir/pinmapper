# frozen_string_literal: true

class General::MoreButtonComponent < ViewComponent::Base
  attr_reader :display

  def initialize(display: true)
    @display = display
  end

  def render?
    display
  end
end
