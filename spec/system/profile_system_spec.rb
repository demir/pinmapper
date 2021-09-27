# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :system, js: true do
  let!(:user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: user) }

  it 'visits profiles#show from pins#index' do
    visit pins_path
    first('.pin > .header > .user > span > a').click
    expect(page).to have_css '.profile .header .information .item span', text: user.email
  end

  it 'visits profiles#show from pins#show' do
    visit pin_path(id: pins.first)
    expect(page).to have_css '.singlepost > .postmeta .user > a', text: user.email
  end
end
