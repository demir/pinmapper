module ActiveRecord
  module Searchable
    extend ActiveSupport::Concern

    included do
      include PgSearch::Model

      pg_search_scope :pg_search,
                      against: :tsv,
                      using:   {
                        tsearch: { prefix: true, tsvector_column: 'tsv' }
                      }
    end
  end
end
