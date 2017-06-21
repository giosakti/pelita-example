require "spec_helper"
require_relative "../../../../app/models/user"
require_relative "../../../../app/models/blog_post"
require_relative "../../../../app/concepts/blog_post/operation/create"

RSpec.describe BlogPost::Create do
  let (:anonymous) { User.new(false) }
  let (:signed_in) { User.new(true) }
  let (:pass_params) { { blog_post: { title: "Puns: Ode to Joy" } } }

  it "fails with anonymous" do
    result = BlogPost::Create.(pass_params, "current_user" => anonymous)

    expect(result).to be_failure
    expect(result["model"]).to be_nil
    expect(result["result.policy.default"]).to be_failure
  end
end
