# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::PinListItemComponent, type: :component do
  let(:pins) { create_list(:pin, 3) }

  before do
    render_inline(described_class.with_collection(pins))
  end

  it 'first#name' do
    expect(rendered_component).to have_css 'li h3 a', text: pins.first.name
  end

  it 'second#name' do
    expect(rendered_component).to have_css 'li h3 a', text: pins.second.name
  end

  it 'third#name' do
    expect(rendered_component).to have_css 'li h3 a', text: pins.third.name
  end

  it 'first#tag_list' do
    expect(rendered_component.squish).to have_css 'li small',
                                                  text: pins.first
                                                            .tag_list
                                                            .map { |t| "##{t}" }
                                                            .join(' ')
  end

  it 'second#first_tag' do
    expect(rendered_component.squish).to have_css 'li small',
                                                  text: pins.second
                                                            .tag_list
                                                            .map { |t| "##{t}" }
                                                            .join(' ')
  end

  it 'third#first_tag' do
    expect(rendered_component.squish).to have_css 'li small',
                                                  text: pins.third
                                                            .tag_list
                                                            .map { |t| "##{t}" }
                                                            .join(' ')
  end
end
