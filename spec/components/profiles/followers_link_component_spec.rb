# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::FollowersLinkComponent, type: :component do
  let(:user) { create(:user, :confirmed) }

  context 'with user' do
    before do
      render_inline(described_class.new(user: user))
    end

    it 'shows link' do
      expect(rendered_component).to have_css '.black-link', text: /#{I18n.t('followers_tr')}/
    end
  end

  context 'without user' do
    before do
      render_inline(described_class.new(user: nil))
    end

    it 'do not show link' do
      expect(rendered_component).not_to have_css '.black-link'
    end
  end
end