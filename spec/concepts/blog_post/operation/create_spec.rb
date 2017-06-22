require "spec_helper"
require_relative "../../../../lib/railway_eng/entities/blog_post"
require_relative "../../../../lib/railway_eng/entities/user"
require_relative "../../../../lib/railway_eng/persistence/repositories/blog_post_repo"
require_relative "../../../../app/concepts/blog_post/operation/create"

RSpec.describe BlogPost::Create do
  include ImportMain["blog_post_repo"]

  let (:anonymous) { RailwayEng::Entities::User.new(signed_in: false) }
  let (:signed_in) { RailwayEng::Entities::User.new(signed_in: true) }
  let (:pass_params) { { blog_post: { title: "Puns: Ode to Joy" } } }

  it "fails with anonymous" do
    result = BlogPost::Create.(pass_params, "current_user" => anonymous)

    expect(result).to be_failure
    expect(result["model"]).to be_nil
    expect(result["result.policy.default"]).to be_failure
  end

  it "works with known user" do
    result = BlogPost::Create.(
      { blog_post: { title: "Puns: Ode to Joy", body: "" } },
      "current_user" => signed_in
    )
    expect(result).to be_success
    expect(blog_post_repo.persisted?(result["model"])).to eq(true)
    expect(result["model"].title).to eq("Puns: Ode to Joy")
  end

  it "fails with missing input" do
    result = BlogPost::Create.({}, "current_user" => signed_in)
    expect(result).to be_failure
  end

  it "fails with body too short" do
    result = BlogPost::Create.(
      { blog_post: { title: "Heatwave!", body: "Too hot!" } },
      "current_user" => signed_in
    )

    expect(result).to be_failure
    expect(result["result.contract.default"].errors.messages).to eq(
      {:body => ["size cannot be less than 9"]} )
  end
end
