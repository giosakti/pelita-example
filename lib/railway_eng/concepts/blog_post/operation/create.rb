require "trailblazer"
require_relative "../contract/create"

class BlogPost::Create < Trailblazer::Operation
  include ImportMain["blog_post_repo"]

  step Policy::Guard( :authorize! )
  step :validate!
  step :persist!
  step :notify!

  def authorize!(options, current_user:, **)
    current_user.signed_in?
  end

  def validate!(options, params:, **)
    result = BlogPost::Contract::Create.call(params[:blog_post])
    options["result.contract.default"] = result
    result.success?
  end

  def persist!(options, params:, **)
    options["model"] = RailwayEng::Entities::BlogPost.new(params[:blog_post])
    options["model"] = blog_post_repo.create(options["model"])
  end

  def notify!(options, current_user:, model:, **)
    # BlogPost::Notification.(current_user, model)
    true
  end
end
