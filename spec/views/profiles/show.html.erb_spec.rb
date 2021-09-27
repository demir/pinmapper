# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profiles/show.html.erb', type: :view do
  let(:user) { create(:user, :confirmed) }

  before do
    assign(:user, user)
  end

  context 'renders profile header' do
    before do
      render
    end

    it 'user avatar' do
      assert_select '.profile > .header > .user-avatar'
    end

    it 'user email' do
      expect(rendered).to match(/#{user.email}/)
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

    it 'follow button' do
      assert_select '.profile > .header > .information .item .btn_1', count: 1
    end
  end

  context 'renders body' do
    it 'pins' do
      create_list(:pin, 2, user: user)
      render
      assert_select '.profile .pin', count: 2
    end
  end
end
