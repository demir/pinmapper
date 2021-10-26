# frozen_string_literal: true

require 'rails_helper'

RSpec.describe General::SearchComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:path) { pins_path }

  before do
    render_inline(described_class.new(path: path, current_user: current_user))
  end

  context 'form' do
    it 'controller' do
      expect(rendered_component).to have_css 'form[data-controller="search"]'
    end

    it 'controller url value' do
      expect(rendered_component).to have_css "form[data-search-url-value='#{path}']"
    end

    it 'controller action' do
      expect(rendered_component).to have_css 'form[data-action="keydown->search#disable_enter"]'
    end
  end

  describe 'form elements' do
    context 'name' do
      it 'id' do
        expect(rendered_component).to have_css 'input[id="name"]'
      end

      it 'name' do
        expect(rendered_component).to have_css 'input[name="name"]'
      end

      it 'controller action' do
        expect(rendered_component).to have_css 'input[data-action="input->search#search"]'
      end
    end
  end
end
