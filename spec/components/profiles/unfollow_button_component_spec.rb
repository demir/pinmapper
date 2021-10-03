# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::UnfollowButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:user) { create(:user, :confirmed) }

  context 'with current_user' do
    context 'when not following to user' do
      it 'do not show button' do
        render_inline(described_class.new(user: user, current_user: current_user))
        expect(rendered_component).not_to have_css '.btn_1'
      end
    end

    context 'when following to user' do
      before do
        FollowServices::FollowUser.call(current_user, user)
        render_inline(described_class.new(user: user, current_user: current_user))
      end

      it 'shows unfollow button with following text' do
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('following')
      end
    end

    it 'do not show button when current_user and user are same' do
      render_inline(described_class.new(user: current_user, current_user: current_user))
      expect(rendered_component).not_to have_css '.btn_1'
    end
  end

  context 'without current_user' do
    before do
      render_inline(described_class.new(user: user, current_user: nil))
    end

    it 'do not show button' do
      expect(rendered_component).not_to have_css '.btn_1'
    end
  end
end
