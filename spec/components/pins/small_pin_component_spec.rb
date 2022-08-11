# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::SmallPinComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  context 'pin attributes' do
    before do
      render_inline(described_class.new(pin: pin, current_user: user))
    end

    it 'user#image class' do
      expect(rendered_component).to have_css '.small-pin .image'
    end

    it 'user#username' do
      expect(rendered_component).to have_css '.small-pin .body small .small-username', text: pin.user.username
    end

    it 'pin#name' do
      expect(rendered_component).to have_css '.small-pin .body h6 a.black-link', text: pin.name
    end

    it 'location icon' do
      expect(rendered_component).to have_css '.small-pin .body .icon_pin_alt'
    end

    it 'location information' do
      expect(rendered_component).to have_css '.small-pin .body small.address', text: pin.city_country
    end

    it 'add to board button' do
      expect(rendered_component).to have_css '.small-pin .body a.add_to_board_btn'
    end
  end

  # rubocop:disable RSpec/RepeatedExampleGroupBody
  context 'data sort url' do
    let(:board) { create(:board, user: user) }

    context 'with current_user' do
      before do
        render_inline(described_class.new(pin: pin, current_user: user, board: board, drag_sort: true))
      end

      it 'data sort url' do
        move_pin_path = move_pin_board_path(board, pin.id, locale: I18n.locale)
        expect(rendered_component).to have_css ".small-pin[data-sort-url='#{move_pin_path}']"
      end
    end

    context 'without current_user' do
      before do
        render_inline(described_class.new(pin: pin, current_user: nil, board: board, drag_sort: true))
      end

      it 'data sort url' do
        expect(rendered_component).to have_css '.small-pin[data-sort-url=""]'
      end
    end

    context 'with board' do
      before do
        render_inline(described_class.new(pin: pin, current_user: user, board: board, drag_sort: true))
      end

      it 'data sort url' do
        move_pin_path = move_pin_board_path(board, pin.id, locale: I18n.locale)
        expect(rendered_component).to have_css ".small-pin[data-sort-url='#{move_pin_path}']"
      end
    end

    context 'without board' do
      before do
        render_inline(described_class.new(pin: pin, current_user: user, board: nil, drag_sort: true))
      end

      it 'data sort url' do
        expect(rendered_component).to have_css '.small-pin[data-sort-url=""]'
      end
    end

    context 'when drag_sort true' do
      before do
        render_inline(described_class.new(pin: pin, current_user: user, board: board, drag_sort: true))
      end

      it 'data sort url' do
        move_pin_path = move_pin_board_path(board, pin.id, locale: I18n.locale)
        expect(rendered_component).to have_css ".small-pin[data-sort-url='#{move_pin_path}']"
      end
    end

    context 'when drag_sort false' do
      before do
        render_inline(described_class.new(pin: pin, current_user: user, board: nil, drag_sort: false))
      end

      it 'data sort url' do
        expect(rendered_component).to have_css '.small-pin[data-sort-url=""]'
      end
    end
  end
  # rubocop:enable RSpec/RepeatedExampleGroupBody
end
