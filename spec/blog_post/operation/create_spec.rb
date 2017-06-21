require "spec_helper"
require_relative "../../../app/blog_post/operation/create"

RSpec.describe BlogPost::Create do
  it do
    result = BlogPost::Create.( { happy: "yes" } )
    expect(result.success?).to be_truthy
  end

  it do
    result = BlogPost::Create.( { happy: false } )
    expect(result.failure?).to be_truthy
    expect(result["joke"]).to eq "Broken pencils are pointless."
  end
end
