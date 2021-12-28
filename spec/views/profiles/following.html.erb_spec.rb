# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profiles/following.html.erb', type: :view do
  let(:user) { create(:user, :confirmed) }

  before do
    assign(:user, user)
    assign(:following, [])
  end

  context 'without any data' do
    context "current user's profile" do
      it 'no data for following' do
        sign_in(user)
        render
        expect(rendered).to match(/#{t('profiles.following.no_data_for_current_user')}/)
      end
    end

    context 'others profile' do
      it 'no data for following' do
        render
        expect(rendered).to match(/#{t('profiles.following.no_data')}/)
      end
    end
  end
end
