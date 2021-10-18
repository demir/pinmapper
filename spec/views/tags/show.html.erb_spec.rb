# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tags/show.html.erb', type: :view do
  include Pagy::Backend
  let(:user) { create(:user, :confirmed) }
  let(:tag) { create(:tag) }
  let(:pins) do
    pin_attributes = attributes_for(:pin, user_id: user.id, tag_list: tag)
    create_list(:pin, 2, pin_attributes)
  end
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    tag.users << user
    assign(:current_user, user)
    assign(:pins, pins)
    assign(:tag, tag)
    assign(:pagy, pagy_obj)
  end

  context 'renders tag header when user not signed in' do
    before do
      render
    end

    it 'without follow/unfollow buton'
  end

  context 'renders tag header when user signed in' do
    before do
      sign_in(user)
      render
    end

    it 'follow button'
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
