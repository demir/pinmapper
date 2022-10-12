# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Embed', type: :system, js: true do
  let(:current_user) { create(:user, :confirmed) }
  let(:embed) { build(:embed, :video) }

  before do
    sign_in(current_user)
  end

  it 'adds embed' do
    # cookies-bar değiştirilirse aşağıdaki 2 satıra gerek kalmayabilir
    visit root_path
    find('.cookies-bar > .btn_1').click
    visit new_pin_path
    expect(page).to have_css 'button#trix-embed-button', text: I18n.t('embeds.embed_button_name')
  end
end
