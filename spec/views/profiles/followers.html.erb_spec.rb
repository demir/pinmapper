# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profiles/followers.html.erb', type: :view do
  let(:user) { create(:user, :confirmed) }

  before do
    assign(:user, user)
    assign(:followers, [])
  end

  context 'without any data' do
    it 'no data for followers' do
      render
      expect(rendered).to match(/#{t('profiles.followers.no_data')}/)
    end
  end
end
