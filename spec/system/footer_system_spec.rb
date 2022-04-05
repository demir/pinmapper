# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Footer', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: current_user) }

  context 'page titles' do
    it '#about' do
      visit about_path
      expect(page.title).to include I18n.t('shared.footer.about')
    end

    it '#cookie_policy' do
      visit cookie_policy_path
      expect(page.title).to include I18n.t('shared.footer.cookie_policy')
    end

    it '#privacy_policy' do
      visit privacy_policy_path
      expect(page.title).to include I18n.t('shared.footer.privacy_policy')
    end

    it '#terms_of_use' do
      visit terms_of_use_path
      expect(page.title).to include I18n.t('shared.footer.terms_of_use')
    end
  end

  context 'with signed_in' do
    before do
      sign_in(current_user)
    end

    it 'switch language' do
      pin = pins.first
      visit pin_path(id: pin, locale: :en)
      find('.dropdown-lang').click
      click_link 'Türkçe'
      expect(page).to have_current_path pin_path(pin, locale: :tr)
    end
  end

  context 'without signed_in' do
    it 'switch language' do
      pin = pins.first
      visit pin_path(id: pin, locale: :en)
      find('.dropdown-lang').click
      click_link 'Türkçe'
      expect(page).to have_current_path pin_path(pin, locale: :tr)
    end
  end
end
