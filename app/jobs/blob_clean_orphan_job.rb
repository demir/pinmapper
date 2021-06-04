# frozen_string_literal: true

class BlobCleanOrphanJob < ApplicationJob
  queue_as :default

  def perform(blob_id)
    blob = ActiveStorage::Blob.find_by(id: blob_id)
    return unless blob
    return if ActiveStorage::Attachment.exists?(blob_id: blob_id)

    blob.purge_later
  end
end
