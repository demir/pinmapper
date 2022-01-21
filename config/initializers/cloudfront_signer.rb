Aws::CF::Signer.configure do |config|
  config.key = Rails.application.credentials.dig(:aws, :cloud_front, :private_key)
  config.key_pair_id = Rails.application.credentials.dig(:aws, :cloud_front, :key_pair_id)
  config.default_expires = 3600
end
