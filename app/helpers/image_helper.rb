# frozen_string_literal: true

module ImageHelper
  # rubocop:disable Metrics/AbcSize
  def thumbor_crop(crop_constraints, metadata = nil)
    return '' if crop_constraints.blank?

    crop_constraints = crop_constraints[:crop].map(&:to_i)
    x = [crop_constraints[0], metadata&.dig('width')].compact.min
    y = [crop_constraints[1], metadata&.dig('height')].compact.min
    width = [crop_constraints[2], metadata&.dig('width')].compact.min
    height = [crop_constraints[3], metadata&.dig('height')].compact.min

    "#{x}x#{y}:#{width}x#{height}"
  end
  # rubocop:enable Metrics/AbcSize

  def cloudfront_src(thumbor_crop: '', filters: '', image_key: '')
    return '' if image_key.blank?

    Aws::CF::Signer.sign_url(
      "#{Rails.application.credentials.dig(:aws, :cloud_front, :api_endpoint)}/#{thumbor_crop}/#{filters}/#{image_key}"
    )
  end
end
