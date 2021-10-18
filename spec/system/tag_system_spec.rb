# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags', type: :system, js: true do
  let!(:current_user) { create(:user, :confirmed) }
  let(:tag) { create(:tag) }
  let(:pins) do
    pin_attributes = attributes_for(:pin, user_id: current_user.id, tag_list: tag)
    create_list(:pin, 2, pin_attributes)
  end

  context 'when signed in' do
    before do
      sign_in(current_user)
    end

    context 'tags#show' do
      it '#follow' do
        visit tag_path(id: tag)
        find('.tag > .header a.btn_1', text: I18n.t('follow')).click
        expect(page).to have_css '.tag > .header a.btn_1', text: I18n.t('unfollow')
      end

      it '#unfollow' do
        current_user.tags << tag
        visit tag_path(id: tag)
        find('.tag > .header a.btn_1', text: I18n.t('following_tr')).click
        expect(page).to have_css '.tag > .header a.btn_1', text: I18n.t('follow')
      end
    end
  end
end
