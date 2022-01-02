# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::AvatarComponent, type: :component do
  before do
    render_inline(described_class.new(src: ActionController::Base.helpers.asset_pack_path('media/images/avatar.jpg')))
  end

  it 'renders img tag' do
    expect(rendered_component).to have_css 'img'
  end

  it 'rounded' do
    expect(rendered_component).to have_css '.rounded-circle'
  end

  it 'has user-avatar default class' do
    expect(rendered_component).to have_css '.user-avatar'
  end

  it 'default width 40px' do
    expect(page).to have_css('img[width="40"]')
  end

  it 'default height 40px' do
    expect(page).to have_css('img[height="40"]')
  end
end
