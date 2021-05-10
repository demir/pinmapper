# frozen_string_literal: true

class Pins::MoreButtonComponent < ViewComponent::Base
  def initialize(pin:, current_user: nil)
    @pin = pin
    @current_user = current_user
  end
end
