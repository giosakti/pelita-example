module RailwayEng
  module Persistence
    module Repository
      class BlogPostRepo < Pelita::Repository::Base[:blog_posts]
        commands :create, update: :by_pk, delete: :by_pk

        def persisted?(record)
          !record.id.nil?
        end

        def [](id)
          blog_posts
            .by_pk(id)
            .as(Entity::BlogPost)
            .one!
        end
      end
    end
  end
end
