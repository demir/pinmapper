# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageHelper, type: :helper do
  let(:crop_constraints) { { crop: [3, 55, 19, 24] } }

  it 'thumbor_crop' do
    expect(helper.thumbor_crop(crop_constraints)).to eq('3x55:19x24')
  end

  it 'cloudfront_src' do
    cloud_front_url = Rails.application.credentials.dig(:aws, :cloud_front, :api_endpoint)
    expect(helper.cloudfront_src(filters: '400x400/filters:quality(40)',
                                 thumbor_crop: helper.thumbor_crop(crop_constraints), image_key: '18493')).to(
                                   include("#{cloud_front_url}/3x55:19x24/400x400/filters:quality(40)/18493?Expires=")
                                 )
  end
end
