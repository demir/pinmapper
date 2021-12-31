# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pins', type: :system, js: true do
  let!(:user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: user) }

  context 'signed in or not signed in' do
    it 'visits tags/show' do
      visit pins_path
      first_tag_element = find('.pin > .body > .pin-tag', match: :first)
      first_tag_element.click
      expect(page).to have_css '.tag > .header > .tag-name', text: first_tag_element.text
    end
  end

  context 'When signed in' do
    before do
      sign_in(user)
    end

    it '#liked_pins' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('liked_pins')
      expect(page).to have_css '.liked-pins > .header'
    end

    it 'visits pins' do
      visit root_path
      click_link I18n.t('pins.pins')
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

    describe 'add to board' do
      context 'when there is no board' do
        it 'shows there is no board message' do
          visit pins_path
          pin = pins.last
          pin_element = find("#add-pin-to-board-dropdown_pin_#{pin.id}")
          pin_element.find('#add-pin-to-board-menu').click
          expect(page).to have_css "#add-pin-to-board-dropdown_pin_#{pin.id} .body .no-boards > span",
                                   text: I18n.t('boards.there_is_no_boards')
        end
      end

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
      expect(page).to have_css '.pin-show', text: pin.name
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
      fill_in Pin.human_attribute_name(:cover_image_description), with: Faker::Lorem.paragraph
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
      expect(page).to have_css '.pin-show .header h1', text: new_name
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
          pin_element = more_button.ancestor('.pin-show')
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
          pin_element = more_button.ancestor('.pin-show')
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
    it 'visits pins' do
      visit root_path
      click_link I18n.t('pins.pins')
      expect(page).to have_css '.row .pin', count: 2
    end

    it 'does not render more button' do
      visit pins_path
      expect(page).not_to have_css '.pin .pin-more'
    end

    it 'visits pin#show' do
      visit pins_path
      pin = pins.last
      click_link pin.name
      expect(page).to have_css '.pin-show .header h1', text: pin.name
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
end
