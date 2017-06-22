require "trailblazer"
require_relative "../contract/create"

class BlogPost::Create < Trailblazer::Operation
  include ImportMain["blog_post_repo"]

  step Policy::Guard( :authorize! )
  step :model!
  # TODO: @giosakti maybe reform isn't the best option for this
  step Contract::Build( constant: BlogPost::Contract::Create )
  step Contract::Validate( key: :blog_post )
  step :persist!
  step :notify!

  def authorize!(options, current_user:, **)
    current_user.signed_in?
  end

  def model!(options, params:, **)
    options["model"] = RailwayEng::Entities::BlogPost.new(params[:blog_post])
  end

  def persist!(options, params:, model:, **)
    options["model"] = blog_post_repo.create(params[:blog_post])
  end

  def notify!(options, current_user:, model:, **)
    # BlogPost::Notification.(current_user, model)
    true
  end
end
