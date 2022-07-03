# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'errors/internal_server_error.html.erb', type: :view do
  before do
    render
  end

  context 'elements' do
    it '#error_page' do
      expect(rendered).to have_css 'main #error_page .justify-content-center h2', text: 500
    end

    it '#message_one' do
      expect(rendered).to have_css 'main #error_page .justify-content-center p',
                                   text: I18n.t('errors.internal_server_error.message_one')
    end

    it '#message_two' do
      expect(rendered).to have_css 'main #error_page .justify-content-center p',
                                   text: I18n.t('errors.internal_server_error.message_two')
    end
  end
end
