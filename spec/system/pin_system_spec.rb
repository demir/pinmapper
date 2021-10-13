# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pins', type: :system, js: true do
  let!(:user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: user) }

  context 'When signed in' do
    before do
      sign_in(user)
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

    it 'visits pin#show via pin name link' do
      visit pins_path
      pin = pins.first
      click_link pin.name
      expect(page).to have_css '.singlepost .header h1', text: pin.name
    end

    it 'renders a new pin button' do
      visit pins_path
      expect(page).to have_css 'header ul', text: I18n.t('shared.header.new_pin')
    end

    it 'visits pin#new' do
      visit pins_path
      click_link I18n.t('shared.header.new_pin')
      expect(page).to have_current_path new_pin_path
    end

    it 'creates a new pin' do
      visit new_pin_path
      fill_in Pin.human_attribute_name(:name), with: Faker::Address.city
      fill_in Pin.human_attribute_name(:address), with: 'Samsun, Türkiye'
      find(:css, 'select#pin_privacy').find(:option, Pin.translated_privacy(:public)).select_option
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
      pin = pins.first
      visit edit_pin_path(id: pin)
      expect(page).to have_field(Pin.human_attribute_name(:name), with: pin.name)
    end

    it 'edits a pin' do
      pin = pins.first
      visit edit_pin_path(id: pin)
      new_name = Faker::Lorem.sentence
      fill_in User.human_attribute_name(:name), with: new_name
      click_button I18n.t('helpers.submit.update')
      expect(page).to have_content I18n.t('pins.update.success')
      expect(page).to have_css '.singlepost .header h1', text: new_name
    end

    it 'renders edit template after validation errors' do
      pin = pins.first
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
          expect(page).to have_current_path pins_path
          expect(page).to have_content I18n.t('pins.destroy.success')
        end
      end

      context 'from the show page' do
        it 'visits the edit page' do
          pin = pins.first
          visit pin_path(id: pin)
          more_button = find('.container .header .pin-more svg', match: :first)
          pin_element = more_button.ancestor('.singlepost')
          more_button.click
          edit_pin_link_element = pin_element.find('.header .dropdown.pin-more .dropdown-menu a',
                                                   text:       I18n.t('edit'),
                                                   exact_text: true)
          edit_pin_link_element.click
          expect(page).to have_current_path edit_pin_link_element[:href]
          expect(page).to have_field(Pin.human_attribute_name(:name), with: pin.name)
        end

        it 'deletes a pin' do
          pin = pins.first
          visit pin_path(id: pin)
          more_button = find('.container .header .pin-more svg', match: :first)
          pin_element = more_button.ancestor('.singlepost')
          more_button.click
          delete_pin_link_element = pin_element.find('.header .dropdown.pin-more .dropdown-menu a',
                                                     text:       I18n.t('destroy'),
                                                     exact_text: true)
          delete_pin_link_element.click
          page.accept_alert
          expect(page).to have_current_path pins_path
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
      pin = pins.first
      click_link pin.name
      expect(page).to have_css '.singlepost .header h1', text: pin.name
    end

    it 'does not render new pin button' do
      visit pins_path
      expect(page).not_to have_css '.sticky_horizontal .actions .btn_1', text: I18n.t('pins.index.new_pin')
    end

    context 'when visits pin paths with address bar' do
      describe '#new' do
        it 'redirects to sign in page' do
          visit new_pin_path
          expect(page).to have_current_path new_user_session_path
          expect(page).to have_content I18n.t('devise.failure.unauthenticated')
        end
      end

      describe '#edit' do
        it 'redirects to sign in page' do
          pin = pins.first
          visit edit_pin_path(id: pin)
          expect(page).to have_current_path new_user_session_path
          expect(page).to have_content I18n.t('devise.failure.unauthenticated')
        end
      end
    end
  end
end
