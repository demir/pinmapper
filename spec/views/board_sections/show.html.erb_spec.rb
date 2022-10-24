require 'rails_helper'

RSpec.describe "board_sections/show", type: :view do
  before(:each) do
    @board_section = assign(:board_section, BoardSection.create!(
      name: "Name",
      board: nil,
      pins_count: 2,
      slug: "Slug",
      position: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/3/)
  end
end
