# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ToastrHelper, type: :helper do
  describe '#toastr_flash_class' do
    it 'alert to error' do
      expect(helper.toastr_flash_class('alert')).to eq('toastr.error')
    end

    it 'notice to success' do
      expect(helper.toastr_flash_class('notice')).to eq('toastr.success')
    end

    it 'other types to info' do
      expect(helper.toastr_flash_class('other_types')).to eq('toastr.info')
    end
  end
end
