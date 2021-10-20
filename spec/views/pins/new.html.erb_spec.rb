# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/new', type: :view do
  before do
    user = create(:user, :confirmed)
    assign(:pin, build(:pin, user: user))
  end

  it 'renders new pin form' do
    render

    assert_select 'form[action=?][method=?]', pins_path, 'post' do
      assert_select 'input[name=?]', 'pin[name]'

      assert_select 'input[name=?]', 'pin[address]'

      assert_select 'input[name=?]', 'pin[cover_image]'

      assert_select 'textarea[name=?]', 'pin[cover_image_description]'

      assert_select 'input[name=?]', 'pin[tag_list]'

      assert_select 'input[name=?]', 'pin[description]'
    end
  end
end
