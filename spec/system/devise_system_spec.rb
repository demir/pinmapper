# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Devise', type: :system, js: true do
  let(:user) do
    create(:user, :confirmed,
           password:              'password',
           password_confirmation: 'password')
  end

  context 'page titles' do
    it 'confirmations#new' do
      visit new_user_confirmation_path
      expect(page.title).to include I18n.t('devise.confirmations.new.title')
    end

    it 'passwords#new' do
      visit new_user_password_path
      expect(page.title).to include I18n.t('devise.passwords.new.title')
    end

    it 'registrations#new' do
      visit new_user_registration_path
      expect(page.title).to include I18n.t('devise.registrations.new.title')
    end

    it 'sessions#new' do
      visit new_user_session_path
      expect(page.title).to include I18n.t('devise.sessions.new.title')
    end
  end

  context 'session' do
    it 'signs in' do
      visit root_path
      click_link I18n.t('devise.sign_in')
      fill_in User.human_attribute_name(:email), with: user.email
      fill_in User.human_attribute_name(:password), with: user.password
      click_button I18n.t('devise.sign_in')
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end

    it 'signs out' do
      sign_in user
      visit root_path
      find('.dropdown-user').click
      click_button I18n.t('devise.sign_out')
      expect(page).to have_content I18n.t('devise.sign_in')
    end

    it 'resend confirmation instructions' do
      visit root_path
      click_link I18n.t('devise.sign_in')
      click_link I18n.t('resend')
      new_user = create(:user)
      fill_in User.human_attribute_name(:email), with: new_user.email
      click_button I18n.t('send')
      expect(page).to have_content I18n.t('devise.confirmations.send_instructions')
    end

    it 'confirm resended confirmation instructions' do
      visit new_user_confirmation_path
      new_user = create(:user)
      fill_in User.human_attribute_name(:email), with: new_user.email
      click_button I18n.t('send')
      ctoken = extract_token(Devise.mailer.deliveries.last, 'confirmation_token')
      visit "#{user_confirmation_path}?confirmation_token=#{ctoken}"
      expect(page).to have_content I18n.t('devise.confirmations.confirmed')
    end
  end

  context 'registration' do
    it 'signs up without confirmation' do
      visit root_path
      click_link I18n.t('devise.sign_up'), match: :first
      sign_up
      expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
    end

    it 'confirms account' do
      visit new_user_registration_path
      sign_up
      ctoken = extract_token(Devise.mailer.deliveries.last, 'confirmation_token')
      visit "#{user_confirmation_path}?confirmation_token=#{ctoken}"
      expect(page).to have_content I18n.t('devise.confirmations.confirmed')
    end
  end

  context 'password' do
    it 'sends reset password instructions to email' do
      visit root_path
      click_link I18n.t('devise.sign_in')
      click_link I18n.t('devise.sessions.new.forgot_password')
      send_reset_password_instructions
      expect(page).to have_content I18n.t('devise.passwords.send_instructions')
    end

    it 'resets password' do
      visit new_user_password_path
      send_reset_password_instructions
      rptoken = extract_token(Devise.mailer.deliveries.last, 'reset_password_token')
      visit "#{edit_user_password_path}?reset_password_token=#{rptoken}"
      fill_in I18n.t('devise.passwords.edit.new_password'), with: 'password'
      fill_in I18n.t('devise.passwords.edit.new_password_confirmation'), with: 'password'
      click_button I18n.t('devise.passwords.edit.change_my_password')
      expect(page).to have_content I18n.t('devise.passwords.updated')
    end
  end

  private

  def sign_up
    fill_in User.human_attribute_name(:email), with: Faker::Internet.unique.email
    fill_in User.human_attribute_name(:username), with: SecureRandom.hex(15)
    fill_in User.human_attribute_name(:password), with: 'password'
    fill_in User.human_attribute_name(:password_confirmation), with: 'password'
    click_button I18n.t('devise.register')
  end

  def send_reset_password_instructions
    fill_in User.human_attribute_name(:email), with: user.email
    click_button I18n.t('devise.passwords.new.send_reset_link')
  end

  def extract_token(email, type)
    return if email.blank? || email.body.blank?

    email.body.match(/#{type}=(.+)">/x)[1]
  end
end
