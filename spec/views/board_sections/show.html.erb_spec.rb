# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe 'board_sections/show', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end
  let(:board) { create(:board, user: current_user) }
  let(:board_section) { create(:board_section, board:) }
  let(:pins_array) { create_list(:pin, 2) }
  let(:pins) { Pin.where(id: pins_array.pluck(:id)) }

  before do
    board_section.pins << pins
    assign(:board_section, board_section)
    assign(:pagy, pagy_obj)
  end

  context 'when user not signed in' do
    before do
      render
    end

    it 'not renders more button' do
      assert_select '.general-more .dropdown-item:nth-of-type(1)', text: t('edit'), count: 0
    end
  end

  context 'renders board section header when user signed in' do
    let(:new_board_section) { create(:board_section) }

    before do
      sign_in(current_user)
    end

    it 'more button' do
      render
      assert_select '.general-more .dropdown-item:nth-of-type(1)', text: t('edit')
    end
  end

  context 'renders attributes of board section (sign in not required)' do
    before do
      render
    end

    it '#name' do
      expect(rendered).to match(/#{board_section.name}/)
    end

    it '#description' do
      expect(rendered).to match(/#{board_section.description}/)
    end

    it 'map' do
      assert_select '.map[data-map-target="container"]'
    end

    it 'renders a list of small pins' do
      assert_select '.small-pin .image', count: 2
      assert_select '.small-pin .body h6 a.black-link', count: 2
      assert_select '.small-pin .body small .small-username', count: 2
      assert_select '.small-pin .body small.address', count: 2
      assert_select '.small-pin .body i.icon_pin_alt', count: 2
      assert_select '#infinite-pins.body'
    end
  end

  context 'drag sort' do
    it 'drag sort controller' do
      render
      assert_select '.body[data-controller="drag-sort"]'
    end

    context 'with current user' do
      let(:new_board_section) { create(:board_section) }

      before do
        sign_in(current_user)
      end

      it 'active when owner of board section' do
        render
        assert_select '.body[data-drag-sort-state-value="true"]'
      end

      it 'deactive when not owner of board' do
        assign(:board_section, new_board_section)
        render
        assert_select '.body[data-drag-sort-state-value="false"]'
      end
    end

    context 'without current user' do
      it 'deactive' do
        render
        assert_select '.body[data-drag-sort-state-value="false"]'
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
