require 'rails_helper'

RSpec.describe "board_sections/new", type: :view do
  before(:each) do
    assign(:board_section, BoardSection.new(
      name: "MyString",
      board: nil,
      pins_count: 1,
      slug: "MyString",
      position: 1
    ))
  end

  it "renders new board_section form" do
    render

    assert_select "form[action=?][method=?]", board_sections_path, "post" do

      assert_select "input[name=?]", "board_section[name]"

      assert_select "input[name=?]", "board_section[board_id]"

      assert_select "input[name=?]", "board_section[pins_count]"

      assert_select "input[name=?]", "board_section[slug]"

      assert_select "input[name=?]", "board_section[position]"
    end
  end
end
