# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::Latest, type: :service do
  describe '#call' do
    subject(:latest_pins) { described_class.call(user: current_user, pagy: pagy) }

    let!(:current_user) { create(:user, :confirmed) }
    let!(:pins) { create_list(:pin, 5, user: current_user) }
    let!(:pagy) { Pagy.new(count: Pin.count(:all), page: 1) }

    context 'order by created at' do
      # rubocop:disable Lint/UnexpectedBlockArity
      it 'show first if last created pin' do
        expect(latest_pins.first).to eq(pins.max { |p| p[:created_at] })
      end

      it 'show last if first created pin' do
        expect(latest_pins.last).to eq(pins.min { |p| p[:created_at] })
      end
      # rubocop:enable Lint/UnexpectedBlockArity

      context 'class methods' do
        it '#tag_pins' do
          current_user.tags << pins.first&.tags&.first
          described_class.tag_pins(current_user, pagy).any?
        end

        it '#board_pins' do
          board = create(:board)
          board.followers << current_user
          described_class.board_pins(current_user, pagy).any?
        end

        it '#own_and_following_pins' do
          described_class.own_and_following_pins(current_user, pagy).any?
        end

        it '#nearby_pins' do
          described_class.nearby_pins(pins.first, pagy).any?
        end
      end
    end
  end
end
