# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Taggable::ListItemComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:tags) { create_list(:tag, 10) }

  before do
    render_inline(described_class.with_collection(tags, current_user: current_user))
  end

  it 'tag#name link' do
    expect(rendered_component).to have_css '.tag > span > a.black-link'
  end
end
