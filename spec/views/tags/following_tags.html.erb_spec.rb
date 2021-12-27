# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tags/following_tags', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:tags) { create_list(:tag, 2) }
  let(:pagy_obj) do
    ar_tags = ActsAsTaggableOn::Tag.where(id: tags.pluck(:id))
    pagy(ar_tags).first
  end

  before do
    sign_in(current_user)
    current_user.tags << tags.first
    current_user.tags << tags.second
    assign(:current_user, current_user)
    assign(:tags, tags)
    assign(:pagy, pagy_obj)
  end

  context 'with any tag' do
    before do
      render
    end

    it 'renders header' do
      assert_select '.following-tags > .header', text: "#{t('following_tags')} (#{tags.count})"
    end

    it 'renders a list of tags' do
      expect(rendered).to have_css '.following-tags > .body .tag-list-item', count: 2
    end
  end

  context 'without any tag' do
    it 'shows no data message' do
      assign(:tags, [])
      render
      expect(rendered).to have_css '.following-tags > .body .tag-list-item', count: 0
      assert_select '.no-data p', text: I18n.t('tags.following_tags.no_data'), count: 1
    end
  end
end
