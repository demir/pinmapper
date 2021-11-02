Rails.configuration.to_prepare do
  ActiveStorage::Blob.include ActiveStorage::BlobExtension
  ActiveRecord::Base.include ActiveRecord::FindByOrderedIds
end
