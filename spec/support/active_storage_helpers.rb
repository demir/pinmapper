# frozen_string_literal: true

module ActiveStorageHelpers
  def create_file_blob(filename: 'test-attachment.png',
                       content_type: 'image/png',
                       metadata: nil,
                       service_name: nil,
                       record: nil)
    ActiveStorage::Blob.create_and_upload! io:           file_fixture(filename).open,
                                           filename:,
                                           content_type:,
                                           metadata:,
                                           service_name:,
                                           record:
  end
end

RSpec.configure do |config|
  config.include ActiveStorageHelpers
end
