# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::FollowUserListItemComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:followers) { create_list(:user, 10, :confirmed) }

  before do
    render_inline(described_class.with_collection(followers, current_user: current_user))
  end

  it 'user#avatar' do
    expect(rendered_component).to have_css '.user > img.user-avatar'
  end

  it 'user#username link' do
    expect(rendered_component).to have_css '.user > span > a.soft-black-link'
  end
end
