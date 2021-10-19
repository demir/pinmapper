# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagPolicy, type: :policy do
  subject(:tag_policy) { described_class }

  let(:current_user) { create(:user, :confirmed) }
  let(:tag) { create(:tag) }

  permissions :following_tags? do
    it 'denies access without current_user' do
      expect(tag_policy).not_to permit(nil, tag)
    end

    it 'grants access with current_user' do
      expect(tag_policy).to permit(current_user, tag)
    end
  end

  permissions :follow? do
    it 'can not follow without current_user' do
      expect(tag_policy).not_to permit(nil, tag)
    end

    it 'denies access if already followed by current_user' do
      current_user.tags << tag
      expect(tag_policy).not_to permit(current_user, tag)
    end

    it 'grants access if not followed by current_user' do
      expect(tag_policy).to permit(current_user, tag)
    end
  end

  permissions :unfollow? do
    it 'can not unfollow without current_user' do
      expect(tag_policy).not_to permit(nil, tag)
    end

    it 'denies access if not followed by current_user' do
      expect(tag_policy).not_to permit(current_user, tag)
    end

    it 'grants access if liked by current_user' do
      current_user.tags << tag
      expect(tag_policy).to permit(current_user, tag)
    end
  end
end
