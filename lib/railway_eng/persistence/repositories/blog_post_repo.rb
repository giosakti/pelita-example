require 'rom-repository'

module RailwayEng
  module Persistence
    module Repositories
      class BlogPostRepo < ROM::Repository[:blog_posts]
        commands :create, update: :by_pk, delete: :by_pk

        def persisted?(record)
          !record.id.nil?
        end
      end
    end
  end
end
