require 'rails_helper'

RSpec.describe Pins::TagListComponent, type: :component do
  it 'renders tags' do
    pin = create(:pin)
    render_inline(described_class.new(tag_list: pin.tag_list))
    expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.first}"
    expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.second}"
    expect(rendered_component).to have_css '.pin-tag', text: "##{pin.tag_list.third}"
  end
end
