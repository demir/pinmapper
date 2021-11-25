# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boards', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let!(:boards) { create_list(:board, 2, user: current_user) }

  context 'When signed in' do
    before do
      sign_in(current_user)
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
      click_link I18n.t('boards.following_boards')
      expect(page).to have_css '.boards > .header h2', text: I18n.t('boards.following_boards')
    end

    it 'renders more button' do
      visit boards_path
      expect(page).to have_css '.board .board-more'
    end

    it 'visits boards#show via board name link' do
      visit boards_path
      board = boards.first
      click_link board.name
      expect(page).to have_css '.board-show > .header > .main_title_3 > h2', text: board.name
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
        it 'visits the edit page' do
          visit boards_path
          more_button = find('.board > .item .board-more > svg', match: :first)
          board_element = more_button.ancestor('.board')
          more_button.click
          edit_board_link_element = board_element.find('.dropdown.board-more .dropdown-menu a',
                                                       text:       I18n.t('edit'),
                                                       exact_text: true)
          edit_board_link_element.click
          expect(page).to have_current_path edit_board_link_element[:href]
          expect(page).to have_field(Board.human_attribute_name(:name),
                                     with: board_element.find('span > a.black-link').text)
        end

        it 'deletes a board' do
          visit boards_path
          more_button = find('.board > .item .board-more > svg', match: :first)
          board_element = more_button.ancestor('.board')
          more_button.click
          delete_board_link_element = board_element.find('.dropdown.board-more .dropdown-menu a',
                                                         text:       I18n.t('destroy'),
                                                         exact_text: true)
          delete_board_link_element.click
          page.accept_alert
          expect(page).to have_content I18n.t('boards.destroy.success')
        end
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
      expect(page).not_to have_css '.board .board-more'
    end
  end
end
