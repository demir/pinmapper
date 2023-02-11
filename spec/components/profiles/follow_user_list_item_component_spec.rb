# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::FollowUserListItemComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:followers) { create_list(:user, 3, :confirmed) }

  before do
    render_inline(described_class.with_collection(followers, current_user:))
  end

  it 'user#avatar' do
    expect(page).to have_css '.user > img.user-avatar'
  end

  it 'user#username link' do
    expect(page).to have_css '.user > span > a.username'
  end
end
