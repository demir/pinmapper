# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject(:profile_policy) { described_class }

  let(:current_user) { create(:user, :confirmed) }
  let(:user) { create(:user, :confirmed) }

  permissions :follow? do
    it 'can not follow without current_user' do
      expect(profile_policy).not_to permit(nil, user)
    end

    it 'denies access if already followed by current_user' do
      FollowServices::FollowUser.call(current_user, user)
      expect(profile_policy).not_to permit(current_user, user)
    end

    it 'grants access if not followed by current_user' do
      expect(profile_policy).to permit(current_user, user)
    end
  end

  permissions :unfollow? do
    it 'can not unfollow without current_user' do
      expect(profile_policy).not_to permit(nil, user)
    end

    it 'denies access if not followed by current_user' do
      expect(profile_policy).not_to permit(current_user, user)
    end

    it 'grants access if liked by current_user' do
      FollowServices::FollowUser.call(current_user, user)
      expect(profile_policy).to permit(current_user, user)
    end
  end
end
