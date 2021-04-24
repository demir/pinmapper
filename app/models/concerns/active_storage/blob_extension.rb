module ActiveStorage::BlobExtension
  extend ActiveSupport::Concern
  included do
    after_create :queue_job

    private

    def queue_job
      BlobCleanOrphanJob.set(wait: 1.day).perform_later(id)
    end
  end
end
