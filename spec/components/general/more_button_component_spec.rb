# frozen_string_literal: true

require 'rails_helper'

RSpec.describe General::MoreButtonComponent, type: :component do
  context 'display true' do
    it 'renders' do
      render_inline(described_class.new(display: true))
      expect(page).to have_css '.general-more'
    end

    it 'renders content' do
      render_inline(described_class.new(display: true).with_content('<p>Hello Pinmapper!</p>'))
      expect(page).to have_css '.general-more .dropdown-menu', text: '<p>Hello Pinmapper!</p>'
    end
  end

  context 'display false' do
    before do
      render_inline(described_class.new(display: false))
    end

    it 'not renderes' do
      expect(page).not_to have_css '.general-more'
    end

    it 'not renders content' do
      render_inline(described_class.new(display: false).with_content('<p>Hello Pinmapper!</p>'))
      expect(page).not_to have_css '.general-more .dropdown-menu', text: '<p>Hello Pinmapper!</p>'
    end
  end
end
