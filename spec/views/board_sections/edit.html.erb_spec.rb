require 'rails_helper'

RSpec.describe "board_sections/edit", type: :view do
  before(:each) do
    @board_section = assign(:board_section, BoardSection.create!(
      name: "MyString",
      board: nil,
      pins_count: 1,
      slug: "MyString",
      position: 1
    ))
  end

  it "renders the edit board_section form" do
    render

    assert_select "form[action=?][method=?]", board_section_path(@board_section), "post" do

      assert_select "input[name=?]", "board_section[name]"

      assert_select "input[name=?]", "board_section[board_id]"

      assert_select "input[name=?]", "board_section[pins_count]"

      assert_select "input[name=?]", "board_section[slug]"

      assert_select "input[name=?]", "board_section[position]"
    end
  end
end
