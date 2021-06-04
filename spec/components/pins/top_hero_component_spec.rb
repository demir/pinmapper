# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pins::TopHeroComponent, type: :component do
  it 'renders background image which has a hero_in class' do
    expect(
      render_inline(described_class.new(title: I18n.t('pins.pin'))).css('.animate__fadeInUp').to_html
    ).to include(
      I18n.t('pins.pin')
    )
  end
end
