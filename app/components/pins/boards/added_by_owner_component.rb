# frozen_string_literal: true

module Pins
  module Boards
    class AddedByOwnerComponent < ViewComponent::Base
      include Turbo::FramesHelper
      attr_reader :pin, :current_user

      delegate :count, to: :owner_boards, prefix: true

      def initialize(pin:, current_user:)
        @pin = pin
        @current_user = current_user
      end

      def render?
        owner_boards_count.positive?
      end

      def owner_boards
        pin.owner_public_boards
      end

      def single?
        owner_boards_count == 1
      end

      def plural?
        owner_boards_count > 1
      end

      def plural_one_or_other
        plural? && owner_boards_count == 2 ? 'one' : 'other'
      end
    end
  end
end
