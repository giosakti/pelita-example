require "trailblazer"
require_relative "../contract/create"

class BlogPost::Create < Trailblazer::Operation
  include ImportMain["blog_post_repo"]

  step Policy::Guard( :authorize! )
  step :model!
  # TODO: @giosakti maybe reform isn't the best option for this
  step :build!
  step :validate!
  step :persist!
  step :notify!

  def authorize!(options, current_user:, **)
    current_user.signed_in?
  end

  def model!(options, params:, **)
    options["model"] = RailwayEng::Entities::BlogPost.new(params[:blog_post])
  end

  def build!(options, **)
    options["result.contract.default"] = BlogPost::Contract::Create.new(options["model"])
  end

  def validate!(options, params:, **)
    reform_contract = options["result.contract.default"]
    result = reform_contract.validate(params || {})
  end

  def persist!(options, params:, **)
    options["model"] = blog_post_repo.create(options["model"])
  end

  def notify!(options, current_user:, model:, **)
    # BlogPost::Notification.(current_user, model)
    true
  end
end
