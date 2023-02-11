# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/show', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end
  let(:board) { create(:board, user: current_user) }
  let(:pins_array) { create_list(:pin, 2) }
  let(:pins) { Pin.where(id: pins_array.pluck(:id)) }

  before do
    board.pins << pins
    board.board_sections << create_list(:board_section, 3, board:)
    assign(:board, board)
    assign(:pins, pins)
    assign(:map_pins, pins)
    assign(:pagy, pagy_obj)
  end

  context 'when user not signed in' do
    before do
      render
    end

    it 'without follow/unfollow buton' do
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 0
    end

    it 'not renders more button' do
      assert_select '.general-more .dropdown-item:nth-of-type(1)', text: t('edit'), count: 0
    end

    it 'not renders create section button' do
      assert_select '.board-sections-header > a.btn_1.outline',
                    text:  t('board_sections.index.create_new_board_section'),
                    count: 0
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  context 'renders board header when user signed in' do
    let(:new_board) { create(:board) }

    before do
      sign_in(current_user)
    end

    it 'more button' do
      render
      assert_select '.general-more .dropdown-item:nth-of-type(1)', text: t('edit')
    end

    it 'do not show follow button when following board' do
      current_user.following_boards << new_board
      render
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 0
    end

    it 'do not show follow button when board owner is current_user' do
      current_user.following_boards << board
      render
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 0
    end

    it 'show follow button when not following board' do
      assign(:board, new_board)
      render
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 1
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers

  context 'renders attributes of board (sign in not required)' do
    before do
      render
    end

    it '#name' do
      expect(rendered).to match(/#{board.name}/)
    end

    it '#description' do
      expect(rendered).to match(/#{board.description}/)
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

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  context 'board section' do
    context 'without current_user' do
      it 'not renders create section button' do
        render
        assert_select '.board-sections-header > a.btn_1.outline',
                      text:  t('board_sections.index.create_new_board_section'),
                      count: 0
      end

      it 'renders board sections' do
        render
        assert_select '.board-section', count: 3
      end

      it 'not renders more button' do
        render
        assert_select '.board-section .general-more .dropdown-item:nth-of-type(1)', text: t('edit'), count: 0
      end

      it 'not daggable' do
        render
        assert_select '.body:has(.board-section)[data-drag-sort-state-value="false"]', count: 1
      end

      context 'without any board' do
        let(:new_board) { create(:board) }

        before do
          assign(:board, new_board)
          render
        end

        it 'does not shows section header' do
          assert_select '.board-sections-header .title', count: 0
        end

        it 'does not shows no data message' do
          assert_select '.board-section span > a.name', count: 0
          assert_select '.no-data p', text: I18n.t('boards.show.no_board_section_data_for_current_user'), count: 0
        end
      end
    end

    context 'with current_user' do
      before do
        sign_in(current_user)
      end

      it 'renders board sections' do
        render
        assert_select '.board-section', count: 3
      end

      it 'renders more button' do
        render
        assert_select '.board-section .general-more .dropdown-item:nth-of-type(1)', text: t('edit'), count: 3
      end

      it 'drag sort controller' do
        render
        assert_select '.body:has(.board-section)[data-controller="drag-sort"]', count: 1
      end

      it 'daggable' do
        render
        assert_select '.body:has(.board-section)[data-drag-sort-state-value="true"]', count: 1
      end

      context 'without any board' do
        it 'shows no data message' do
          new_board = create(:board, user: current_user)
          assign(:board, new_board)
          render
          assert_select '.board-section span > a.name', count: 0
          assert_select '.no-data p', text: I18n.t('boards.show.no_board_section_data_for_current_user'), count: 1
        end
      end
    end
  end

  context 'drag sort' do
    it 'drag sort controller' do
      render
      assert_select '.body[data-controller="drag-sort"]'
    end

    context 'with current user' do
      let(:new_board) { create(:board) }

      before do
        sign_in(current_user)
      end

      it 'active when owner of board' do
        render
        assert_select '.body[data-drag-sort-state-value="true"]'
      end

      it 'deactive when not owner of board' do
        assign(:board, new_board)
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
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
