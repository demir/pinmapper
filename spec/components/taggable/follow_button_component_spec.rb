# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Taggable::FollowButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:tag) { create(:tag) }

  context 'with current_user' do
    before do
      render_inline(described_class.new(tag: tag, current_user: current_user))
    end

    context 'when not following to tag' do
      it 'shows button' do
        render_inline(described_class.new(tag: tag, current_user: current_user))
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('follow')
      end
    end

    context 'when following to tag' do
      before do
        current_user.tags << tag
        render_inline(described_class.new(tag: tag, current_user: current_user))
      end

      it 'do not show button' do
        expect(rendered_component).not_to have_css '.btn_1'
      end
    end
  end

  context 'without current_user' do
    before do
      render_inline(described_class.new(tag: tag, current_user: nil))
    end

    it 'do not show button' do
      expect(rendered_component).not_to have_css '.btn_1'
    end
  end
end
