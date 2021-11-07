# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let!(:user) { create(:user, :confirmed) }
  let!(:pins) { create_list(:pin, 2, user: user) }

  it 'visits profiles#show from pins#index' do
    visit pins_path
    first('.pin > .header > .user > span > a').click
    expect(page).to have_css '.profile .header .information .item span', text: user.username
  end

  it 'visits profiles#show from pins#show' do
    visit pin_path(id: pins.first)
    expect(page).to have_css '.pin-show > .header .hrow > a', text: user.username
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

      it 'visits edit_profile' do
        visit profile_path(id: current_user)
        click_link I18n.t('settings.edit_profile')
        expect(page).to have_current_path settings_edit_profile_path
      end

      it 'can not edit_profile other users' do
        visit profile_path(id: user)
        expect(page).not_to have_css '.profile > .header > .information .item .btn_1.soft-black-border',
                                     text: I18n.t('settings.edit_profile')
      end
    end
  end
end
