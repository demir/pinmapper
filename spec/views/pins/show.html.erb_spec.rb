require 'rails_helper'

RSpec.describe 'pins/show', type: :view do
  before do
    @pin = assign(:pin, Pin.create!(
                          name:                    'Name',
                          address:                 'Address',
                          latitude:                '9.99',
                          longitude:               '9.99',
                          privacy:                 3,
                          cover_image_description: 'MyText'
                        ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
  end
end
