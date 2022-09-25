# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::Boards::AddToBoardButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:pin) { create(:pin) }

  before do
    render_inline(described_class.new(pin:, current_user:))
  end

  describe 'dropdown div' do
    it 'id' do
      expect(page).to have_css "div[id='add-pin-to-board-dropdown_pin_#{pin.id}']"
    end

    it 'controller' do
      expect(page).to have_css 'div[data-controller="dropdown"]'
    end

    it 'classes' do
      expect(page).to have_css 'div[class="dropdown dropstart add-pin-to-board-dropdown"]'
    end

    it 'controller id value' do
      expect(page).to have_css "div[data-dropdown-id-value='add-pin-to-board-dropdown_pin_#{pin.id}']"
    end
  end

  describe 'dropdown-menu button' do
    it 'id' do
      expect(page).to have_css 'a[id="add-pin-to-board-menu"]'
    end

    context 'if added any pin to board' do
      let(:board) { create(:board, user: current_user) }

      before do
        board.pins << pin
        render_inline(described_class.new(pin:, current_user:))
      end

      it 'class' do
        expect(page).to have_css 'a[class="add_to_board_btn added"]'
      end
    end

    context 'if there is no added pin to board' do
      it 'class' do
        expect(page).to have_css 'a[class="add_to_board_btn"]'
      end
    end
  end

  describe 'dropdown-menu div' do
    it 'class' do
      expect(page).to have_css 'div[class="dropdown-menu add-pin-to-board"]'
    end

    it 'data-action' do
      expect(page).to(
        have_css('div[data-action="turbo:frame-load->dropdown#updateButton"]')
      )
    end
  end

  describe 'header' do
    it 'dropdown header text' do
      expect(page).to have_css '.header span', text: I18n.t('boards.add_to_board')
    end
  end

  context 'when there is board' do
    before do
      current_user.boards << create(:board)
      render_inline(described_class.new(pin:, current_user:))
    end

    describe 'header' do
      it 'renders search form' do
        expect(page).to have_css '.header .search-form'
      end
    end

    describe 'body' do
      it 'boards header text' do
        expect(page).to have_css '.body span', text: I18n.t('boards.boards')
      end

      context 'create new board button' do
        it 'class' do
          expect(page).to have_css '.btn_1.outline.full-width'
        end

        it 'link' do
          expect(page).to have_css "a[href='#{new_board_path(locale: I18n.locale, pin_id: pin)}']",
                                   text: I18n.t('boards.index.create_new_board')
        end
      end

      context 'turbo frame' do
        it 'id' do
          expect(page).to have_css "turbo-frame[id='add_to_board_list_body_pin_#{pin.id}']"
        end

        it 'src' do
          expect(page).to(
            have_css("turbo-frame[src='#{add_to_board_list_boards_path(pin_id: pin, locale: I18n.locale)}']")
          )
        end

        it 'loading' do
          expect(page).to have_css 'turbo-frame[loading="lazy"]'
        end

        it 'spinner' do
          expect(page).to have_css '.body .justify-content-center .spinner-border.pinmapper.m-4'
        end
      end
    end
  end
end
