require "trailblazer"
require_relative "../contract/create"

class BlogPost::Create < Trailblazer::Operation
  step Policy::Guard( :authorize! )
  step :model!
  step Contract::Build( constant: BlogPost::Contract::Create )
  step Contract::Validate( key: :blog_post )
  step Contract::Persist()
  step :notify!

  def authorize!(options, current_user:, **)
    current_user.signed_in?
  end

  def model!(options, **)
    options["model"] = BlogPost.new
  end

  def notify!(options, current_user:, model:, **)
    # BlogPost::Notification.(current_user, model)
    true
  end
end
