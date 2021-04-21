require 'rails_helper'

RSpec.describe 'pins/index', type: :view do
  before do
    assign(:pins, [
             Pin.create!(
               name:                    'Name',
               address:                 'Address',
               latitude:                '9.99',
               longitude:               '9.99',
               category:                2,
               privacy:                 3,
               cover_image_description: 'MyText'
             ),
             Pin.create!(
               name:                    'Name',
               address:                 'Address',
               latitude:                '9.99',
               longitude:               '9.99',
               category:                2,
               privacy:                 3,
               cover_image_description: 'MyText'
             )
           ])
  end

  it 'renders a list of pins' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Address'.to_s, count: 2
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
