# frozen_string_literal: true

module ImageHelper
  def thumbor_crop(crop_constraints)
    return '' if crop_constraints.blank?

    crop_constraints = crop_constraints[:crop].map(&:to_i)
    "#{crop_constraints[0]}x#{crop_constraints[1]}:#{crop_constraints[2]}x#{crop_constraints[3]}"
  end

  def cloudfront_src(thumbor_crop: '', filters: '', image_key: '')
    return '' if image_key.blank?

    Aws::CF::Signer.sign_url(
      "#{Rails.application.credentials.dig(:aws, :cloud_front, :api_endpoint)}/#{thumbor_crop}/#{filters}/#{image_key}"
    )
  end
end
