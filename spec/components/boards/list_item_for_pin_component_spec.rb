# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Boards::ListItemForPinComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:boards) { create_list(:board, 10, user: current_user) }
  let(:pin) { create(:pin) }

  before do
    render_inline(described_class.with_collection(boards, pin: pin, current_user: current_user))
  end

  it 'board name' do
    expect(rendered_component).to have_css '.board-name'
  end

  it 'add or remove button' do
    expect(rendered_component).to have_css '.btn_1'
  end
end
