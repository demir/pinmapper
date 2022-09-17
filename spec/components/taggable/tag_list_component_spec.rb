# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Taggable::TagListComponent, type: :component do
  let!(:pin) { create(:pin) }

  before do
    render_inline(described_class.new(tags: pin.tags))
  end

  it 'renders first tag' do
    expect(page).to have_css '.pin-tag', text: "##{pin.tags.first.name}"
  end

  it 'renders second tag' do
    expect(page).to have_css '.pin-tag', text: "##{pin.tags.second.name}"
  end

  it 'renders third tag' do
    expect(page).to have_css '.pin-tag', text: "##{pin.tags.third.name}"
  end
end
