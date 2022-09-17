# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::FollowingLinkComponent, type: :component do
  let(:user) { create(:user, :confirmed) }

  context 'with user' do
    before do
      render_inline(described_class.new(user:))
    end

    it 'shows link' do
      expect(page).to have_css '.black-link-555', text: /#{I18n.t('following_tr')}/
    end
  end

  context 'without user' do
    before do
      render_inline(described_class.new(user: nil))
    end

    it 'do not show link' do
      expect(page).not_to have_css '.black-link-555'
    end
  end
end
