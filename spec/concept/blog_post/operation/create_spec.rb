require "spec_helper"

module RailwayEng
  module Concept
    RSpec.describe BlogPost::Create do
      include ImportMain["blog_post_repo"]

      let (:anonymous) { Entity::User.new(signed_in: false) }
      let (:signed_in) { Entity::User.new(signed_in: true) }
      let (:pass_params) { { blog_post: {
        title: "Puns: Ode to Joy",
        body: "La La La La La La La La La La La La La LaLa",
        author: "Author",
      } } }

      it "fails with anonymous" do
        create_blog_post = BlogPost::Create.new
        result = create_blog_post.("params" => pass_params, "current_user" => anonymous)
        expect(result).to be_failure
        expect(result.value["model"]).to be_nil
        expect(result.value["result.policy.default"]).to eq false
      end

      it "works with known user" do
        create_blog_post = BlogPost::Create.new
        result = create_blog_post.("params" => pass_params, "current_user" => signed_in)
        expect(result).to be_success
        expect(blog_post_repo.persisted?(result.value["model"])).to eq(true)
        expect(result.value["model"].title).to eq("Puns: Ode to Joy")
      end

      it "fails with missing input" do
        create_blog_post = BlogPost::Create.new
        result = create_blog_post.("params" => {}, "current_user" => signed_in)
        expect(result).to be_failure
        expect(result.value["result.contract.default"]).to be_failure
      end

      it "fails with body too short" do
        create_blog_post = BlogPost::Create.new
        result = create_blog_post.(
          "params" => { blog_post: { title: "Heatwave!", body: "Too hot!" } },
          "current_user" => signed_in
        )

        expect(result).to be_failure
        expect(result.value["result.contract.default"]).to be_failure
        expect(result.value["result.contract.default"].errors).to eq(
          {:body => ["size cannot be less than 9"]} )
      end
    end
  end
end
