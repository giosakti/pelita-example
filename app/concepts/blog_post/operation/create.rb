require "trailblazer"

class BlogPost::Create < Trailblazer::Operation
  step Policy::Guard( :authorize! )
  step :model!
  step :persist!
  step :notify!

  def authorize!(options, current_user:, **)
    current_user.signed_in?
  end

  def model!(options, **)
    options["model"] = BlogPost.new
  end

  def persist!(options, params:, model:, **)
    model.update_attributes(params[:blog_post])
    model.save
  end

  def notify!(options, current_user:, model:, **)
    BlogPost::Notification.(current_user, model)
  end
end
