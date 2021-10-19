# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/liked_pins', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:pins) { create_list(:pin, 2) }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end

  before do
    sign_in(current_user)
    pins.first.liked_by current_user
    pins.second.liked_by current_user
    assign(:current_user, current_user)
    assign(:pins, pins)
    assign(:pagy, pagy_obj)
    render
  end

  it 'renders header' do
    assert_select '.liked-pins > .header', text: "#{t('liked_pins')} (#{pins.count})"
  end

  it 'renders a list of pins' do
    expect(rendered).to have_css '.pin > .header > .user', count: 2
  end
end
