# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profiles/following.html.erb', type: :view do
  let(:user) { create(:user, :confirmed) }

  before do
    assign(:user, user)
    assign(:following, [])
  end

  context 'without any data' do
    it 'no data for following' do
      render
      expect(rendered).to match(/#{t('profiles.following.no_data')}/)
    end
  end
end
