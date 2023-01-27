# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BoardSections', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let!(:board) { create(:board, user: current_user) }
  let!(:board_sections) { create_list(:board_section, 2, board:) }

  context 'When signed in' do
    before do
      sign_in(current_user)
    end

    context 'page titles' do
      it '#edit' do
        board_section = board_sections.first
        visit edit_board_section_path(id: board_section)
        expect(page.title).to include I18n.t('board_sections.edit.title')
      end

      it '#new' do
        visit new_board_board_section_path(board, locale: I18n.locale)
        expect(page.title).to include I18n.t('board_sections.new.title')
      end

      it '#show' do
        board_section = board_sections.first
        visit board_section_path(id: board_section)
        expect(page.title).to include board_section.name
      end
    end

    it 'list board sections of board' do
      visit board_path(board, locale: I18n.locale)
      expect(page).to have_css '.board-section', count: 2
    end

    it 'renders more button' do
      visit board_section_path(board_sections.first, locale: I18n.locale)
      expect(page).to have_css '.general-more'
    end

    it 'visits board_sections#show via board section name link' do
      visit board_path(board, locale: I18n.locale)
      board_section = board_sections.first
      click_link board_section.name
      expect(page).to have_css '.board-show > .header > .main_title_3 h1', text: board_section.name
    end

    it 'renders a new board section button' do
      visit board_path(board, locale: I18n.locale)
      expect(page).to have_css '.board-show .board-sections-header > a.btn_1.outline',
                               text: I18n.t('board_sections.index.create_new_board_section')
    end

    it 'visits board_section#new' do
      visit board_path(board, locale: I18n.locale)
      click_link I18n.t('board_sections.index.create_new_board_section')
      expect(page).to have_current_path new_board_board_section_path(board, locale: I18n.locale)
    end

    it 'creates a new board section' do
      visit new_board_board_section_path(board, locale: I18n.locale)
      fill_in BoardSection.human_attribute_name(:name), with: Faker::Space.star
      find('trix-editor#board_section_description').click
                                                   .set(Faker::Lorem.paragraph_by_chars(number:       250,
                                                                                        supplemental: false))
      click_button I18n.t('helpers.submit.create')
      expect(page).to have_content I18n.t('board_sections.create.success')
    end

    it 'renders new template after validation errors' do
      visit new_board_board_section_path(board, locale: I18n.locale)
      click_button I18n.t('helpers.submit.create')
      expect(page).to have_content I18n.t('simple_form.error_notification.default_message')
    end

    it 'visits #edit' do
      board_section = board_sections.first
      visit edit_board_section_path(id: board_section)
      expect(page).to have_field(BoardSection.human_attribute_name(:name), with: board_section.name)
    end

    it 'edits a board section' do
      board_section = board_sections.first
      visit edit_board_section_path(board_section, locale: I18n.locale)
      find('.cookies-bar > .btn_1').click
      new_name = SecureRandom.hex(15)
      fill_in BoardSection.human_attribute_name(:name), with: new_name
      click_button I18n.t('helpers.submit.update')
      expect(page).to have_content I18n.t('board_sections.update.success')
      expect(page).to have_css "#board_section_#{board_section.id}", text: new_name
    end

    it 'renders edit template after validation errors' do
      board_section = board_sections.first
      visit edit_board_section_path(id: board_section)
      fill_in BoardSection.human_attribute_name(:name), with: ''
      click_button I18n.t('helpers.submit.update')
      expect(page).to have_content I18n.t('simple_form.error_notification.default_message')
    end

    context 'more button' do
      context 'from the boards#show' do
        # rubocop:disable RSpec/ExampleLength
        it 'visits the edit page' do
          visit board_path(board, locale: I18n.locale)
          more_button = find('.board-section .general-more > svg', match: :first)
          board_section_element = more_button.ancestor('.board-section')
          board_section_element_text = board_section_element.find('.board-section-body a.name').text
          more_button.click
          edit_board_section_link_element = board_section_element.find('.dropdown.general-more .dropdown-menu a',
                                                                       text:       I18n.t('edit'),
                                                                       exact_text: true)
          edit_board_section_link_element_href = edit_board_section_link_element[:href]
          edit_board_section_link_element.click
          expect(page).to have_current_path edit_board_section_link_element_href
          expect(page).to have_field(BoardSection.human_attribute_name(:name),
                                     with: board_section_element_text)
        end
        # rubocop:enable RSpec/ExampleLength

        it 'deletes a board section' do
          visit board_path(board, locale: I18n.locale)
          more_button = find('.board-section .general-more > svg', match: :first)
          board_section_element = more_button.ancestor('.board-section')
          more_button.click
          delete_board_section_link_element = board_section_element.find('.dropdown.general-more .dropdown-menu a',
                                                                         text:       I18n.t('destroy'),
                                                                         exact_text: true)
          delete_board_section_link_element.click
          page.accept_alert
          expect(page).to have_content I18n.t('board_sections.destroy.success')
        end

        it 'merges a board section' do
          visit board_path(board, locale: I18n.locale)
          more_button = find('.board-section .general-more > svg', match: :first)
          board_section_element = more_button.ancestor('.board-section')
          more_button.click
          merge_board_section_link_element = board_section_element.find('.dropdown.general-more .dropdown-menu a',
                                                                        text:       I18n.t('merge'),
                                                                        exact_text: true)
          merge_board_section_link_element.click
          find('.select-board-section.form input#other_board_section_id-ts-control').click
          find('.select-board-section.form .ts-dropdown .option', match: :first).click
          click_button I18n.t('board_sections.select_board_sections.submit')
          expect(page).to have_content I18n.t('board_sections.merge.success')
        end
      end
    end
  end

  context 'When not signed in' do
    it 'renders more button' do
      visit board_section_path(board_sections.first, locale: I18n.locale)
      expect(page).not_to have_css '.board-show .header .general-more'
    end

    it 'initialize leaflet js for map on show' do
      board_section = board_sections.first
      pins = create_list(:pin, 2)
      board_section.pins << pins
      visit board_section_path(board_section, locale: I18n.locale)
      expect(page).to have_css '.map.leaflet-container .leaflet-layer'
    end
  end
end
