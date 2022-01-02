# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Settings', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }

  context 'When signed in' do
    before do
      sign_in(current_user)
    end

    it 'visits change_password' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.change_password')
      expect(page).to have_current_path settings_change_password_path(locale: I18n.locale)
    end

    it 'changes password' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.change_password')
      fill_in User.human_attribute_name(:password), with: '1234567'
      fill_in User.human_attribute_name(:password_confirmation), with: '1234567'
      fill_in User.human_attribute_name(:current_password), with: '123456'
      click_button I18n.t('update')
      expect(page).to have_content I18n.t('settings.users.change_password.password_changed')
    end

    it 'visits change_username' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.change_username')
      expect(page).to have_current_path settings_change_username_path(locale: I18n.locale)
    end

    it 'changes username' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.change_username')
      fill_in User.human_attribute_name(:username), with: SecureRandom.hex(15)
      click_button I18n.t('update')
      expect(page).to have_content I18n.t('settings.users.change_username.username_changed')
    end

    it 'visits change_email' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.change_email')
      expect(page).to have_current_path settings_change_email_path(locale: I18n.locale)
    end

    it 'changes email' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.change_email')
      fill_in User.human_attribute_name(:email), with: Faker::Internet.unique.email
      click_button I18n.t('update')
      expect(page).to have_content I18n.t('settings.users.change_email.email_changed')
    end

    it 'visits edit_profile' do
      visit root_path
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.edit_profile')
      expect(page).to have_current_path settings_edit_profile_path(locale: I18n.locale)
    end

    it 'edits profile' do
      visit root_path
      click_link I18n.t('done')
      find('.dropdown-user').click
      click_link I18n.t('settings.settings')
      click_link I18n.t('settings.edit_profile')
      fill_in Profile.human_attribute_name(:bio), with: 'Pinmapper!'
      click_button I18n.t('update')
      expect(page).to have_content I18n.t('settings.profiles.update.profile_updated')
    end
  end

  context 'When not signed in' do
    it 'not visits change_password' do
      visit settings_change_password_path
      expect(page).not_to have_current_path settings_change_password_path
    end

    it 'not visits change_username' do
      visit settings_change_username_path
      expect(page).not_to have_current_path settings_change_username_path
    end

    it 'not visits change_email' do
      visit settings_change_email_path
      expect(page).not_to have_current_path settings_change_email_path
    end

    it 'not visits edit_profile' do
      visit settings_edit_profile_path
      expect(page).not_to have_current_path settings_edit_profile_path
    end
  end
end
