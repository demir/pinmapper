# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boards', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let!(:boards) { create_list(:board, 2, user: current_user) }

  context 'When signed in' do
    before do
      sign_in(current_user)
    end

    context 'page titles' do
      it '#index' do
        visit boards_path
        expect(page.title).to include I18n.t('boards.boards')
      end

      it '#following_boards' do
        visit following_boards_boards_path
        expect(page.title).to include I18n.t('boards.following_boards.title')
      end

      it '#edit' do
        board = boards.first
        visit edit_board_path(id: board)
        expect(page.title).to include I18n.t('boards.edit.title')
      end

      it '#new' do
        visit new_board_path
        expect(page.title).to include I18n.t('boards.new.title')
      end

      it '#show' do
        board = boards.first
        visit board_path(id: board)
        expect(page.title).to include board.name
      end
    end

    it 'visits boards' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('boards.boards')
      expect(page).to have_css '.boards .board', count: 2
    end

    it '#following_boards' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('boards.following_boards.title')
      expect(page).to have_css '.boards > .header h1', text: I18n.t('boards.following_boards.title')
    end

    it 'renders more button' do
      visit boards_path
      expect(page).to have_css '.board .general-more'
    end

    it 'visits boards#show via board name link' do
      visit boards_path
      board = boards.first
      click_link board.name
      expect(page).to have_css '.board-show > .header > .main_title_3 h1', text: board.name
    end

    it 'renders a new board button' do
      visit boards_path
      expect(page).to have_css '.boards > .header > a.btn_1.outline',
                               text: I18n.t('boards.index.create_new_board')
    end

    it 'visits board#new' do
      visit boards_path
      click_link I18n.t('boards.index.create_new_board')
      expect(page).to have_current_path new_board_path(locale: I18n.locale)
    end

    it 'creates a new board' do
      visit new_board_path
      fill_in Board.human_attribute_name(:name), with: Faker::Space.star
      find('trix-editor#board_description').click
                                           .set(Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false))
      find(:css, 'select#board_privacy').find(:option, Board.translated_privacy(:public)).select_option
      click_button I18n.t('helpers.submit.create')
      expect(page).to have_content I18n.t('boards.create.success')
    end

    it 'renders new template after validation errors' do
      visit new_board_path
      click_button I18n.t('helpers.submit.create')
      expect(page).to have_content I18n.t('simple_form.error_notification.default_message')
    end

    it 'visits #edit' do
      board = boards.first
      visit edit_board_path(id: board)
      expect(page).to have_field(Board.human_attribute_name(:name), with: board.name)
    end

    it 'edits a board' do
      board = boards.first
      visit edit_board_path(id: board)
      find('.cookies-bar > .btn_1').click
      new_name = SecureRandom.hex(15)
      fill_in Board.human_attribute_name(:name), with: new_name
      click_button I18n.t('helpers.submit.update')
      expect(page).to have_content I18n.t('boards.update.success')
      expect(page).to have_css "#board_#{board.id}", text: new_name
    end

    it 'renders edit template after validation errors' do
      board = boards.first
      visit edit_board_path(id: board)
      fill_in Board.human_attribute_name(:name), with: ''
      click_button I18n.t('helpers.submit.update')
      expect(page).to have_content I18n.t('simple_form.error_notification.default_message')
    end

    context 'more button' do
      context 'from the index page' do
        # rubocop:disable RSpec/ExampleLength
        it 'visits the edit page' do
          visit boards_path
          more_button = find('.board > .item .general-more > svg', match: :first)
          board_element = more_button.ancestor('.board')
          board_element_text = board_element.find('span > a.black-link').text
          more_button.click
          edit_board_link_element = board_element.find('.dropdown.general-more .dropdown-menu a',
                                                       text:       I18n.t('edit'),
                                                       exact_text: true)
          edit_board_link_element_href = edit_board_link_element[:href]
          edit_board_link_element.click
          expect(page).to have_current_path edit_board_link_element_href
          expect(page).to have_field(Board.human_attribute_name(:name),
                                     with: board_element_text)
        end
        # rubocop:enable RSpec/ExampleLength

        it 'deletes a board' do
          visit boards_path
          more_button = find('.board > .item .general-more > svg', match: :first)
          board_element = more_button.ancestor('.board')
          more_button.click
          delete_board_link_element = board_element.find('.dropdown.general-more .dropdown-menu a',
                                                         text:       I18n.t('destroy'),
                                                         exact_text: true)
          delete_board_link_element.click
          page.accept_alert
          expect(page).to have_content I18n.t('boards.destroy.success')
        end
      end

      context 'from the show page' do
        # rubocop:disable RSpec/ExampleLength
        it 'merges a board' do
          board = boards.first
          visit board_path(board, locale: I18n.locale)
          more_button = find('.board-show .general-more > svg', match: :first)
          board_element = more_button.ancestor('.board-show .general-more')
          more_button.click
          merge_board_link_element = board_element.find('.dropdown-menu a',
                                                        text:       I18n.t('merge'),
                                                        exact_text: true)
          merge_board_link_element.click
          find('.select-board.form input#other_board_id-ts-control').click
          find('.select-board.form .ts-dropdown .option', match: :first).click
          click_button I18n.t('boards.select_boards.submit')
          expect(page).to have_content I18n.t('boards.merge.success')
        end
        # rubocop:enable RSpec/ExampleLength
      end
    end

    context 'boards#show' do
      let(:board) { create(:board) }

      it '#follow' do
        visit board_path(id: board)
        find('.board-show > .header a.btn_1', text: I18n.t('follow')).click
        expect(page).to have_css '.board-show > .header a.btn_1', text: I18n.t('unfollow')
      end

      it '#unfollow' do
        current_user.following_boards << board
        visit board_path(id: board)
        find('.board-show > .header a.btn_1', text: I18n.t('following_tr')).click
        expect(page).to have_css '.board-show > .header a.btn_1', text: I18n.t('follow')
      end
    end
  end

  context 'When not signed in' do
    it 'renders more button' do
      visit boards_path
      expect(page).not_to have_css '.board .general-more'
    end

    it 'initialize leaflet js for map on show' do
      board = boards.first
      pins = create_list(:pin, 2)
      board.pins << pins
      visit board_path(board, locale: I18n.locale)
      expect(page).to have_css '.map.leaflet-container .leaflet-layer'
    end
  end
end
