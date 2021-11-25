# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Footer', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: current_user) }

  context 'with signed_in' do
    before do
      sign_in(current_user)
    end

    it 'switch language' do
      pin = pins.first
      visit pin_path(id: pin)
      I18n.locale = :en
      find('.dropdown-lang').click
      click_link 'Türkçe'
      expect(page).to have_current_path pin_path(pin, locale: :tr)
    end
  end

  context 'without signed_in' do
    it 'switch language' do
      pin = pins.first
      visit pin_path(id: pin)
      I18n.locale = :en
      find('.dropdown-lang').click
      click_link 'Türkçe'
      expect(page).to have_current_path pin_path(pin, locale: :tr)
    end
  end
end
