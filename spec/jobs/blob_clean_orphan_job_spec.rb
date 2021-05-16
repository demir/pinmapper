# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlobCleanOrphanJob, type: :job do
  describe '#perform_later' do
    it 'cleans orphan blob' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        described_class.set(wait: 1.day).perform_later(1)
      end.to have_enqueued_job
    end
  end
end
