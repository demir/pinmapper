# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profiles/show.html.erb', type: :view do
  include Pagy::Backend
  let(:user) { create(:user, :confirmed) }
  let(:pins) do
    pin_attributes = attributes_for(:pin, user_id: user.id)
    create_list(:pin, 2, pin_attributes)
  end
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    assign(:user, user)
    assign(:user_pins, pins)
    assign(:user_pins_pagy, pagy_obj)
  end

  context 'renders profile header when user not signed in' do
    before do
      render
    end

    it 'without follow/unfollow buton' do
      assert_select '.profile > .header > .information .item .btn_1', count: 0
    end
  end

  context 'renders profile header when user signed in' do
    before do
      sign_in(user)
      render
    end

    context 'when in own profile' do
      it 'without follow button' do
        assert_select '.profile > .header > .information .item .btn_1', text: I18n.t('follow'), count: 0
      end

      it 'edit profile button' do
        assert_select '.profile > .header > .information .item .btn_1.soft-black-border',
                      text: I18n.t('settings.edit_profile'), count: 1
      end
    end
  end

  context 'renders profile header when user signed in or not signed in' do
    before do
      render
    end

    it 'user avatar' do
      assert_select '.profile > .header > .user-avatar'
    end

    it 'user username' do
      expect(rendered).to match(/#{user.username}/)
    end

    it 'pin' do
      expect(rendered).to match(/#{t('activerecord.models.pin')}/)
    end

    it 'followers' do
      expect(rendered).to match(/#{t('followers_tr')}/)
    end

    it 'following' do
      expect(rendered).to match(/#{t('following_tr')}/)
    end

    it 'boards' do
      expect(rendered).to match(/#{t('boards.boards_tr')}/)
    end

    it 'bio' do
      expect(rendered).to match(/#{user.profile.bio}/)
    end
  end

  context 'renders body' do
    it 'pins' do
      render
      assert_select '.profile .pin', count: 2
    end
  end

  context 'without any data' do
    context "current user's profile" do
      it 'no data for pin' do
        sign_in(user)
        assign(:user_pins, [])
        render
        expect(rendered).to match(/#{t('profiles.show.no_data_for_current_user')}/)
      end
    end

    context 'others profile' do
      it 'no data for pin' do
        assign(:user_pins, [])
        render
        expect(rendered).to match(/#{t('profiles.show.no_data')}/)
      end
    end
  end
end
