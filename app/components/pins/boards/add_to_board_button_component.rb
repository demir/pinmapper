# frozen_string_literal: true

module Pins
  module Boards
    class AddToBoardButtonComponent < ViewComponent::Base
      include Turbo::FramesHelper
      attr_reader :pin, :current_user, :klass

      def initialize(pin:, current_user:, klass: '')
        @pin = pin
        @current_user = current_user
        @klass = "add_to_board_btn #{klass}"
      end

      def klass_handled
        pin.boards.where(user: current_user).any? ? "#{klass} added" : klass
      end

      def boards?
        current_user.boards.any?
      end

      def render?
        current_user.present?
      end
    end
  end
end
