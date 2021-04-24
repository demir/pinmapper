Rails.configuration.to_prepare do
  ActiveStorage::Blob.include ActiveStorage::BlobExtension
end
