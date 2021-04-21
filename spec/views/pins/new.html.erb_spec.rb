require 'rails_helper'

RSpec.describe 'pins/new', type: :view do
  before do
    assign(:pin, Pin.new(
                   name:                    'MyString',
                   address:                 'MyString',
                   latitude:                '9.99',
                   longitude:               '9.99',
                   category:                1,
                   privacy:                 1,
                   cover_image_description: 'MyText'
                 ))
  end

  it 'renders new pin form' do
    render

    assert_select 'form[action=?][method=?]', pins_path, 'post' do
      assert_select 'input[name=?]', 'pin[name]'

      assert_select 'input[name=?]', 'pin[address]'

      assert_select 'input[name=?]', 'pin[latitude]'

      assert_select 'input[name=?]', 'pin[longitude]'

      assert_select 'input[name=?]', 'pin[category]'

      assert_select 'input[name=?]', 'pin[privacy]'

      assert_select 'textarea[name=?]', 'pin[cover_image_description]'
    end
  end
end
