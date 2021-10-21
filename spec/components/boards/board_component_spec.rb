# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Boards::BoardComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:boards) { create_list(:board, 10) }

  before do
    render_inline(described_class.with_collection(boards, current_user: current_user))
  end

  it 'board#name link' do
    expect(rendered_component).to have_css '.board > span > a.black-link'
  end
end
