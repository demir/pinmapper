# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let!(:user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: user) }

  it 'visits profiles#show from pins#index' do
    visit pins_path
    first('.pin > .header > .user > span > a').click
    expect(page).to have_css '.profile .header .information .item span', text: user.email
  end

  it 'visits profiles#show from pins#show' do
    visit pin_path(id: pins.first)
    expect(page).to have_css '.pin-show > .postmeta .user > a', text: user.email
  end

  context 'when signed in' do
    before do
      sign_in(current_user)
    end

    context 'profiles#show' do
      it '#follow' do
        visit profile_path(id: user)
        find('.profile > .header > .information .item .btn_1').click
        expect(page).to have_css '.profile > .header > .information .item .btn_1', text: I18n.t('unfollow')
      end

      it '#unfollow' do
        FollowServices::FollowUser.call(current_user, user)
        visit profile_path(id: user)
        find('.profile > .header > .information .item .btn_1').click
        expect(page).to have_css '.profile > .header > .information .item .btn_1', text: I18n.t('follow')
      end
    end
  end
end
