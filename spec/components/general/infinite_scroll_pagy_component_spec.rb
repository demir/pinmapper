# frozen_string_literal: true

require 'rails_helper'

RSpec.describe General::InfiniteScrollPagyComponent, type: :component do
  include Pagy::Frontend
  let(:pagy) { Pagy.new(count: 1000, page: 1) }

  context 'default' do
    before do
      render_inline(described_class.new(pagy:))
    end

    it '#data-controller' do
      expect(page).to have_css 'div[data-controller="infinite-scroll"]'
    end

    it '#data-infinite-scroll-next-page-url-value' do
      expect(page).to(
        have_css("div[data-infinite-scroll-next-page-url-value='#{pagy_url_for(pagy, pagy.next)}']")
      )
    end

    it '#data-infinite-scroll-next-page-value' do
      expect(page).to have_css "div[data-infinite-scroll-next-page-value='#{pagy.next}']"
    end

    it 'data-infinite-scroll-target#scrollArea' do
      expect(page).to have_css 'div[data-infinite-scroll-target="scrollArea"]'
    end

    it 'data-infinite-scroll-target#spinner' do
      expect(page).to have_css 'div[data-infinite-scroll-target="spinner"]'
    end
  end

  context 'html' do
    before do
      render_inline(described_class.new(pagy:, format: :html))
    end

    it 'div#infinite-scroll-pagination' do
      expect(page).to have_css 'div#infinite-scroll-pagination-'
    end

    context 'for record' do
      let(:pin) { create(:pin) }

      before do
        render_inline(described_class.new(pagy:, record: pin, format: :html))
      end

      it 'div#infinite-scroll-pagination' do
        expect(page).to have_css "div#infinite-scroll-pagination-pin_#{pin.id}"
      end
    end
  end

  context 'turbo-stream' do
    before do
      render_inline(described_class.new(pagy:, format: :turbo_stream))
    end

    it '#action' do
      expect(page).to have_css 'turbo-stream[action="update"]'
    end

    it '#target' do
      expect(page).to have_css 'turbo-stream[target="infinite-scroll-pagination-"]'
    end

    context 'for record' do
      let(:pin) { create(:pin) }

      before do
        render_inline(described_class.new(pagy:, record: pin, format: :turbo_stream))
      end

      it 'div#infinite-scroll-pagination' do
        expect(page).to have_css "turbo-stream[target='infinite-scroll-pagination-pin_#{pin.id}']"
      end
    end
  end
end
