require 'import'

module RailwayEng
  module Concept
    class BlogPost::Create < Pelita::Operation::Base
      include Import["blog_post_repo"]

      step :config!
      step :authorize!
      step :validate!
      attempt :persist!, catch: StandardError
      step :notify!

      # dry-transaction does not allow arguments to be passed on the
      # DSL steps. Add extra step instead and pass arguments via options
      def config!(options)
        Right(options)
      end

      def validate!(options)
        params = options["params"]
        result = BlogPost::Contract::Create.call(params[:blog_post])
        options["result.contract.default"] = result

        result.success? ? Right(options) : Left(options)
      end

      def persist!(options)
        params = options["params"]
        options["model"] = Entity::BlogPost.new(params[:blog_post])
        options["model"] = blog_post_repo.create(options["model"])
        Right(options)
      end

      def notify!(options)
        # BlogPost::Notification.(current_user, model)
        Right(options)
      end
    end
  end
end
