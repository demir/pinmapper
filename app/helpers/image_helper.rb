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

    api_endpoint = Rails.application.credentials.dig(:aws, :cloud_front, :api_endpoint)
    path = "/#{thumbor_crop}/#{filters}/#{image_key}".squeeze('/')
    "#{api_endpoint}#{path}?signature=#{signature(path)}"
  end

  private

  def signature(path)
    secret_value = Rails.application.credentials.dig(:aws, :secrets, :pinmapper_prod_dev, :value)
    OpenSSL::HMAC.hexdigest('SHA256', secret_value, path)
  end
end
