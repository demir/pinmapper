require 'rails_helper'

RSpec.describe Pins::PinListItemComponent, type: :component do
  it 'renders pin list items' do
    pins = create_list(:pin, 3)
    render_inline(described_class.with_collection(pins))
    expect(rendered_component).to have_css 'li h3 a', text: pins.first.name
    expect(rendered_component).to have_css 'li h3 a', text: pins.second.name
    expect(rendered_component).to have_css 'li h3 a', text: pins.third.name
    expect(rendered_component.squish).to have_css 'li small', text: pins.first.tag_list.map { |t| "##{t}" }.join(' ')
    expect(rendered_component.squish).to have_css 'li small', text: pins.second.tag_list.map { |t| "##{t}" }.join(' ')
    expect(rendered_component.squish).to have_css 'li small', text: pins.third.tag_list.map { |t| "##{t}" }.join(' ')
  end
end
