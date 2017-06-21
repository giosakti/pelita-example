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

  it "works with known user" do
    result = BlogPost::Create.(
      { blog_post: { title: "Puns: Ode to Joy", body: "" } },
      "current_user" => signed_in
    )
    expect(result).to be_success
    expect(result["model"]).to be_persisted
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
