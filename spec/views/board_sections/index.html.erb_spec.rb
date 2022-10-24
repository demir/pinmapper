require 'rails_helper'

RSpec.describe "board_sections/index", type: :view do
  before(:each) do
    assign(:board_sections, [
      BoardSection.create!(
        name: "Name",
        board: nil,
        pins_count: 2,
        slug: "Slug",
        position: 3
      ),
      BoardSection.create!(
        name: "Name",
        board: nil,
        pins_count: 2,
        slug: "Slug",
        position: 3
      )
    ])
  end

  it "renders a list of board_sections" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Slug".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
