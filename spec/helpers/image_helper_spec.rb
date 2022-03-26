# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageHelper, type: :helper do
  let(:crop_constraints) { { crop: [3, 55, 19, 24] } }
  let(:metadata) { { 'identified' => true, 'width' => 100, 'height' => 100, 'analyzed' => true } }

  it 'thumbor_crop' do
    expect(helper.thumbor_crop(crop_constraints, metadata)).to eq('3x55:19x24')
  end

  it 'thumbor_crop with wrong constraints' do
    expect(helper.thumbor_crop({ crop: [3, 155, 219, 24] }, metadata)).to eq('3x100:100x24')
  end

  it 'cloudfront_src' do
    cloud_front_url = Rails.application.credentials.dig(:aws, :cloud_front, :api_endpoint)
    expect(helper.cloudfront_src(filters:      '400x400/filters:quality(40)',
                                 thumbor_crop: helper.thumbor_crop(crop_constraints, metadata))).to(
                                   include("#{cloud_front_url}/3x55:19x24/400x400/filters:quality(40)/18493")
                                 )
  end
end
