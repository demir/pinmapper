# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profiles/boards.html.erb', type: :view do
  let(:user) { create(:user, :confirmed) }

  before do
    assign(:user, user)
    assign(:boards, [])
  end

  context 'without any data' do
    it 'no data for boards' do
      render
      expect(rendered).to match(/#{t('boards.index.no_data')}/)
    end
  end
end
