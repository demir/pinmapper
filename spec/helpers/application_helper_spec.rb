# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#app_url' do
    it 'without path' do
      expect(helper.app_url(nil)).to eq(Rails.application.credentials.domain)
    end

    it 'with path' do
      path = 'foo/boo'
      expect(helper.app_url(path)).to eq("#{Rails.application.credentials.domain}/#{path}")
    end
  end
end
