# frozen_string_literal: true

class Pins::TopHeroComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
