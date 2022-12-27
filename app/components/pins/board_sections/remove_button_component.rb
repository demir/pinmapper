# frozen_string_literal: true

class Pins::BoardSections::RemoveButtonComponent < ViewComponent::Base
  include Turbo::FramesHelper
  attr_reader :board_section, :pin, :current_user

  def initialize(board_section:, pin:, current_user:)
    @board_section = board_section
    @pin = pin
    @current_user = current_user
  end

  def render?
    return if current_user.blank?
    return if board_section.board.user != current_user

    board_section.pins.include?(pin)
  end
end
