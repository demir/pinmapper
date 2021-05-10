require 'rails_helper'

RSpec.describe 'pins/edit', type: :view do
  before do
    user = create(:user, :confirmed)
    @pin = assign(:pin, create(:pin, user: user))
  end

  it 'renders the edit pin form' do
    render
    assert_select 'form[action=?][method=?]', pin_path(id: @pin), 'post' do
      assert_select 'input[name=?]', 'pin[name]'

      assert_select 'input[name=?]', 'pin[address]'

      assert_select 'select[name=?]', 'pin[privacy]'

      assert_select 'input[name=?]', 'pin[cover_image]'

      assert_select 'textarea[name=?]', 'pin[cover_image_description]'

      assert_select 'input[name=?]', 'pin[tag_list]'

      assert_select 'input[name=?]', 'pin[description]'
    end
  end
end
