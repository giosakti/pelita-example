module RailwayEng
  module Persistence
    module Repositories
      class BlogPostRepo < ROM::Repository[:blog_posts]
        commands :create, update: :by_pk, delete: :by_pk

        def persisted?(record)
          !record.id.nil?
        end

        def [](id)
          blog_posts
            .by_pk(id)
            .as(Entities::BlogPost)
            .one!
        end
      end
    end
  end
end
