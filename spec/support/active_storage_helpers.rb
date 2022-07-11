module ActiveStorageHelpers
  def create_file_blob(key: nil, filename: 'test-attachment.png', content_type: 'image/png', metadata: nil, service_name: nil, record: nil)
    ActiveStorage::Blob.create_and_upload! io: file_fixture(filename).open, filename: filename,
                                           content_type: content_type, metadata: metadata, service_name: service_name, record: record
  end
end

RSpec.configure do |config|
  config.include ActiveStorageHelpers
end
