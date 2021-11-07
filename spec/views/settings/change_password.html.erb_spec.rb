# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'settings/change_password.html.erb', type: :view do
  let(:current_user) { create(:user, :confirmed) }

  context 'with sign in' do
    before do
      sign_in(current_user)
      render
    end

    it '.settings' do
      assert_select '.settings', count: 1
    end

    it 'settings general title' do
      assert_select '.settings .title .main_title_3 h2', text: I18n.t('settings.settings'), count: 1
    end

    it 'sidemenu items count' do
      assert_select '.settings .row .col-lg-3.settings-sidemenu .list-group-item-action', count: 4
    end

    it 'sidemenu active item' do
      assert_select '.settings .row .col-lg-3.settings-sidemenu .list-group-item-action.active',
                    text: I18n.t('settings.change_password'), count: 1
    end

    it 'settings title' do
      assert_select '.settings .col-lg-9.settings-main .header h5', text: I18n.t('settings.change_password'), count: 1
    end

    it 'settings body' do
      assert_select '.settings .col-lg-9.settings-main .body#change_password_form', count: 1
    end

    describe 'form' do
      it 'elements' do
        assert_select '.settings #change_password_form form[action=?][method=?]',
                      settings_users_change_password_path, 'post' do
          assert_select 'input[name=?]', 'user[password]'
          assert_select 'input[name=?]', 'user[password_confirmation]'
          assert_select 'input[name=?]', 'user[current_password]'
        end
      end
    end
  end
end
