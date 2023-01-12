# frozen_string_literal: true

class General::MoreButtonComponent < ViewComponent::Base
  attr_reader :current_user, :turbo, :display

  def initialize(current_user: nil, turbo: true, display: true)
    @current_user = current_user
    @turbo = turbo
    @display = display
  end

  def render?
    display
  end
end
