# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::TagListComponent, type: :component do
  let!(:pin) { create(:pin) }

  before do
    render_inline(described_class.new(tag_list: pin.tag_list))
  end

  it 'renders first tag' do
    expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.first}"
  end

  it 'renders second tag' do
    expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.second}"
  end

  it 'renders third tag' do
    expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.third}"
  end
end
