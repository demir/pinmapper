# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tags/show.html.erb', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:tag) { create(:tag) }
  let(:pins) do
    pin_attributes = attributes_for(:pin, user_id: current_user.id, tag_list: tag)
    create_list(:pin, 2, pin_attributes)
  end
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    assign(:current_user, current_user)
    assign(:pins, pins)
    assign(:tag, tag)
    assign(:pagy, pagy_obj)
  end

  context 'renders tag header when user not signed in' do
    before do
      render
    end

    it 'without follow/unfollow buton' do
      assert_select '.tag > .header a.btn_1', text: I18n.t('follow'), count: 0
    end
  end

  context 'renders tag header when user signed in' do
    before do
      sign_in(current_user)
    end

    it 'do not show follow button when following tag' do
      current_user.tags << tag
      render
      assert_select '.tag > .header a.btn_1', text: I18n.t('follow'), count: 0
    end

    it 'show follow button when following tag' do
      render
      assert_select '.tag > .header a.btn_1', text: I18n.t('follow'), count: 1
    end
  end

  context 'renders tag header when user signed in or not signed in' do
    before do
      render
    end

    it 'tag' do
      expect(rendered).to match(/##{tag.name}/)
    end
  end

  context 'renders body' do
    it 'pins' do
      render
      assert_select '.tag .pin', count: 2
    end
  end
end
