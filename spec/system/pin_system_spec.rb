# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pins', type: :system, js: true do
  let!(:user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: user) }

  context 'signed in or not signed in' do
    it 'visits tags/show' do
      visit explore_index_path
      first_tag_element = find('.pin > .body > .tags .pin-tag', match: :first)
      first_tag_element.click
      expect(page).to have_css '.tag > .header > .tag-name', text: first_tag_element.text
    end
  end

  context 'When signed in' do
    before do
      sign_in(user)
    end

    context 'page titles' do
      it '#index' do
        visit pins_path
        expect(page.title).to include I18n.t('home')
      end

      it '#liked_pins' do
        visit liked_pins_pins_path
        expect(page.title).to include I18n.t('liked_pins')
      end

      it '#edit' do
        pin = pins.first
        visit edit_pin_path(id: pin)
        expect(page.title).to include I18n.t('pins.edit.title')
      end

      it '#new' do
        visit new_pin_path
        expect(page.title).to include I18n.t('pins.new.title')
      end

      it '#show' do
        pin = pins.first
        visit pin_path(id: pin)
        expect(page.title).to include pin.name
      end
    end

    it '#liked_pins' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('liked_pins')
      expect(page).to have_css '.liked-pins > .header'
    end

    it 'visits pins' do
      visit root_path
      click_link I18n.t('home')
      expect(page).to have_css '.row .pin', count: 2
    end

    it 'renders more button' do
      visit pins_path
      expect(page).to have_css '.pin .pin-more'
    end

    it 'likes a pin' do
      visit pins_path
      find('.pin-likes-count .like_btn', match: :first).click
      expect(page).to have_css '.pin-likes-count .like_btn.liked'
    end

    it 'unlikes a pin' do
      visit pins_path
      find('.pin-likes-count .like_btn', match: :first).click
      find('.pin-likes-count .like_btn.liked', match: :first).click
      visit pins_path
      expect(page).not_to have_css '.pin-likes-count .like_btn.liked'
    end

    describe 'explore/location' do
      it 'visits location page from pin' do
        visit pins_path
        address_link = find('.pin .address span > a', match: :first)
        address_link_text = address_link.text
        address_link.click
        expect(page).to have_css '.location .title', text: address_link_text
      end
    end

    describe 'add to board' do
      context 'when there is board' do
        let!(:boards) { create_list(:board, 3, user: user) }

        it 'shows boards' do
          visit pins_path
          pin = pins.last
          pin_element = find("#add-pin-to-board-dropdown_pin_#{pin.id}")
          pin_element.find('#add-pin-to-board-menu').click
          expect(page).to have_css "#add_to_board_list_pin_#{pin.id} > .board-list-item-for-pin",
                                   count: boards.count
        end

        it 'can search' do
          visit pins_path
          pin = pins.last
          board = boards.last
          pin_element = find("#add-pin-to-board-dropdown_pin_#{pin.id}")
          pin_element.find('#add-pin-to-board-menu').click
          fill_in 'name', with: board.name
          expect(page).to have_css "#add_to_board_list_pin_#{pin.id} > .board-list-item-for-pin",
                                   minimum: 1
        end

        it 'add to board' do
          visit pins_path
          pin = pins.last
          pin_element = find("#add-pin-to-board-dropdown_pin_#{pin.id}")
          pin_element.find('#add-pin-to-board-menu').click
          find("#add_to_board_list_pin_#{pin.id} > .board-list-item-for-pin .add-button", match: :first).click
          expect(page).to have_css "#add_to_board_list_pin_#{pin.id} > .board-list-item-for-pin .remove-button",
                                   minimum: 1
        end

        it 'remove from board' do
          visit pins_path
          pin = pins.last
          board = boards.last
          board.pins.destroy_all
          board.pins << pin
          pin_element = find("#add-pin-to-board-dropdown_pin_#{pin.id}")
          pin_element.find('#add-pin-to-board-menu').click
          pin_element.find("#board_#{board.id} .remove-button").click
          expect(page).to have_css "#add_to_board_list_pin_#{pin.id} > .board-list-item-for-pin .remove-button",
                                   count: 0
        end

        it 'can infinite scroll' do
          create_list(:board, 30, user: user)
          visit pins_path
          pin = pins.last
          pin_element = find("#add-pin-to-board-dropdown_pin_#{pin.id}")
          pin_element.find('#add-pin-to-board-menu').click
          scroll_to(pin_element.find(".body #add_to_board_list_pin_#{pin.id}"), align: :bottom)
          expect(page).to have_css "#add_to_board_list_pin_#{pin.id} > .board-list-item-for-pin",
                                   minimum: user.boards_count
        end
      end
    end

    it 'visits pin#show via pin name link' do
      visit pins_path
      pin = pins.first
      click_link pin.name, match: :first
      expect(page).to have_css '.pin-show-main', text: pin.name
    end

    it 'renders a new pin button' do
      visit pins_path
      expect(page).to have_css 'header ul', text: I18n.t('pins.new.create_pin')
    end

    it 'visits pin#new' do
      visit pins_path
      click_link I18n.t('pins.new.create_pin')
      expect(page).to have_current_path new_pin_path(locale: I18n.locale)
    end

    it 'creates a new pin' do
      visit new_pin_path
      fill_in Pin.human_attribute_name(:name), with: Faker::Address.city
      fill_in Pin.human_attribute_name(:address), with: 'Samsun, Türkiye'
      fill_in Pin.human_attribute_name(:cover_photo_description), with: Faker::Lorem.paragraph
      fill_in Pin.human_attribute_name(:tag_list), with: Faker::Lorem.words(number: 3).join(',')
      find('trix-editor#pin_description').click.set(Faker::Lorem.paragraph)
      click_button I18n.t('helpers.submit.create')
      expect(page).to have_content I18n.t('pins.create.success')
    end

    it 'renders new template after validation errors' do
      visit new_pin_path
      click_button I18n.t('helpers.submit.create')
      expect(page).to have_content I18n.t('simple_form.error_notification.default_message')
    end

    it 'visits #edit' do
      pin = pins.last
      visit edit_pin_path(id: pin)
      expect(page).to have_field(Pin.human_attribute_name(:name), with: pin.name)
    end

    it 'edits a pin' do
      pin = pins.last
      visit edit_pin_path(id: pin)
      new_name = Faker::Lorem.sentence
      fill_in User.human_attribute_name(:name), with: new_name
      click_button I18n.t('helpers.submit.update')
      expect(page).to have_content I18n.t('pins.update.success')
      expect(page).to have_css '.pin-show-main .header h1', text: new_name
    end

    it 'renders edit template after validation errors' do
      pin = pins.last
      visit edit_pin_path(id: pin)
      fill_in User.human_attribute_name(:name), with: ''
      click_button I18n.t('helpers.submit.update')
      expect(page).to have_content I18n.t('simple_form.error_notification.default_message')
    end

    context 'more button' do
      context 'from the index page' do
        it 'visits the edit page' do
          visit pins_path
          more_button = find('.pin .header .pin-more svg', match: :first)
          pin_element = more_button.ancestor('.pin')
          more_button.click
          edit_pin_link_element = pin_element.find('.header .dropdown.pin-more .dropdown-menu a',
                                                   text:       I18n.t('edit'),
                                                   exact_text: true)
          edit_pin_link_element.click
          expect(page).to have_current_path edit_pin_link_element[:href]
          expect(page).to have_field(Pin.human_attribute_name(:name), with: pin_element.find('.body h3 a').text)
        end

        it 'deletes a pin' do
          visit pins_path
          more_button = find('.pin .header .pin-more svg', match: :first)
          pin_element = more_button.ancestor('.pin')
          more_button.click
          delete_pin_link_element = pin_element.find('.header .dropdown.pin-more .dropdown-menu a',
                                                     text:       I18n.t('destroy'),
                                                     exact_text: true)
          delete_pin_link_element.click
          page.accept_alert
          expect(page).to have_content I18n.t('pins.destroy.success')
        end
      end

      context 'from the show page' do
        it 'visits the edit page' do
          pin = pins.last
          visit pin_path(id: pin)
          more_button = find('.container .header .pin-more svg', match: :first)
          pin_element = more_button.ancestor('.pin-show-main')
          more_button.click
          edit_pin_link_element = pin_element.find('.header .dropdown.pin-more .dropdown-menu a',
                                                   text:       I18n.t('edit'),
                                                   exact_text: true)
          edit_pin_link_element.click
          expect(page).to have_current_path edit_pin_link_element[:href]
          expect(page).to have_field(Pin.human_attribute_name(:name), with: pin.name)
        end

        it 'deletes a pin' do
          pin = pins.last
          visit pin_path(id: pin)
          more_button = find('.container .header .pin-more svg', match: :first)
          pin_element = more_button.ancestor('.pin-show-main')
          more_button.click
          delete_pin_link_element = pin_element.find(".header .dropdown.pin-more .dropdown-menu
                                                      form.button_to .dropdown-item[value='#{I18n.t('destroy')}']")
          delete_pin_link_element.click
          page.accept_alert
          expect(page).to have_current_path pins_path(locale: I18n.locale)
          expect(page).to have_content I18n.t('pins.destroy.success')
        end
      end
    end
  end

  context 'When not signed in' do
    it 'can not visits pins' do
      visit root_path
      expect(page).not_to have_css '.visible-menu-item span', text: I18n.t('home')
    end

    it 'does not render more button' do
      visit pins_path
      expect(page).not_to have_css '.pin .pin-more'
    end

    it 'visits pin#show' do
      visit explore_index_path
      pin = pins.last
      click_link pin.name
      expect(page).to have_css '.pin-show-main .header h1', text: pin.name
    end

    it 'does not render new pin button' do
      visit pins_path
      expect(page).not_to have_css '.sticky_horizontal .actions .btn_1', text: I18n.t('pins.new.create_pin')
    end

    context 'when visits pin paths with address bar' do
      describe '#new' do
        it 'redirects to sign in page' do
          visit new_pin_path
          expect(page).to have_current_path new_user_session_path(locale: I18n.locale)
          expect(page).to have_content I18n.t('devise.failure.unauthenticated')
        end
      end

      describe '#edit' do
        it 'redirects to sign in page' do
          pin = pins.last
          visit edit_pin_path(id: pin)
          expect(page).to have_current_path new_user_session_path(locale: I18n.locale)
          expect(page).to have_content I18n.t('devise.failure.unauthenticated')
        end
      end
    end
  end

  # rubocop:disable RSpec/NestedGroups
  describe 'pin added to boards by owner' do
    let(:pin) { pins.first }
    let(:board1) { create(:board, user: pin.user) }
    let(:board2) { create(:board, user: pin.user) }

    context 'when not added to any board' do
      it 'do not show any message' do
        visit explore_index_path
        expect(page).not_to have_css "#pin_#{pin.id} .pin-added-by-owner"
      end
    end

    context 'when added to single board' do
      before do
        board1.pins << pin
      end

      it 'show message for single board' do
        visit explore_index_path
        find("#pin_#{pin.id} .pin-added-by-owner a.board-link", text:  pin.owner_public_boards.first.name,
                                                                match: :first).click
        expect(page).to have_css '.board-show'
      end
    end

    context 'when added to one more boards' do
      before do
        board1.pins << pin
        board2.pins << pin
      end

      it 'first board' do
        visit explore_index_path
        find("#pin_#{pin.id} .pin-added-by-owner a.board-link", text:  pin.owner_public_boards.first.name,
                                                                match: :first).click
        expect(page).to have_css '.board-show'
      end

      context 'modal' do
        it 'show modal' do
          visit explore_index_path
          find("#pin_#{pin.id} .pin-added-by-owner a.board-link[data-target=\
            '#pin_boards_added_by_owner_pin_#{pin.id}']").click
          expect(page).to have_css '.pin-boards-added-by-owner-modal.show'
        end

        context 'when boards owner is current_user' do
          before do
            sign_in(pin.user)
          end
          # rubocop:disable RSpec/ExampleLength

          it 'visits the edit page from modal' do
            visit explore_index_path
            find("#pin_#{pin.id} .pin-added-by-owner a.board-link[data-target=\
              '#pin_boards_added_by_owner_pin_#{pin.id}']").click
            modal = find('.pin-boards-added-by-owner-modal.show')
            more_button = modal.find('.board .board-more svg', match: :first)
            board_element = more_button.ancestor('.board')
            board_element_text = board_element.find('.board .board-name').text
            more_button.click
            edit_board_link_element = board_element.find('.item .dropdown.board-more .dropdown-menu a',
                                                         text:       I18n.t('edit'),
                                                         exact_text: true)
            edit_board_link_element_href = edit_board_link_element[:href]
            edit_board_link_element.click
            expect(page).to have_current_path edit_board_link_element_href
            expect(page).to have_field(Board.human_attribute_name(:name), with: board_element_text)
          end

          it 'delete board from modal' do
            visit explore_index_path
            find("#pin_#{pin.id} .pin-added-by-owner a.board-link[data-target=\
              '#pin_boards_added_by_owner_pin_#{pin.id}']").click
            modal = find('.pin-boards-added-by-owner-modal.show')
            more_button = modal.find('.board .board-more svg', match: :first)
            board_element = more_button.ancestor('.board')
            more_button.click
            board_element.find('.item .dropdown.board-more .dropdown-menu a',
                               text:       I18n.t('destroy'),
                               exact_text: true)
                         .click
            page.accept_alert
            expect(page).to have_content I18n.t('boards.destroy.success')
          end
          # rubocop:enable RSpec/ExampleLength
        end

        context 'when boards owner is not current_user' do
          it 'not show board more button' do
            visit explore_index_path
            find("#pin_#{pin.id} .pin-added-by-owner a.board-link[data-target=\
              '#pin_boards_added_by_owner_pin_#{pin.id}']").click
            expect(page).not_to have_css '.pin-boards-added-by-owner-modal.show .board .board-more svg'
          end
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end
