# frozen_string_literal: true

module Boards
  class ListItemForPinComponent < ViewComponent::Base
    include Turbo::FramesHelper
    with_collection_parameter :board
    attr_reader :board, :pin, :current_user

    def initialize(board:, pin:, current_user:)
      @board = board
      @pin = pin
      @current_user = current_user
    end

    def render?
      current_user.present?
    end
  end
end
