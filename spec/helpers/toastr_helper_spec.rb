require 'rails_helper'

RSpec.describe ToastrHelper, type: :helper do
  describe '#toastr_flash_class' do
    it 'returns the toastr method name by type' do
      expect(helper.toastr_flash_class('alert')).to eq('toastr.error')
      expect(helper.toastr_flash_class('notice')).to eq('toastr.success')
      expect(helper.toastr_flash_class('other_types')).to eq('toastr.info')
    end
  end
end
