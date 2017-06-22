require 'dry-auto_inject'
require_relative "../lib/railway_eng/persistence/repositories/blog_post_repo"

adapter = ROM.container(:sql, 'sqlite::memory') do |conf|
  conf.default.create_table(:blog_posts) do
    primary_key :id
    column :title, String, null: false
    column :body, String
    column :author, String
  end
end

main_container = Dry::Container.new
main_container.register(:adapter, adapter)
main_container.register(:blog_post_repo,
  RailwayEng::Persistence::Repositories::BlogPostRepo.new(adapter)
)
ImportMain = Dry::AutoInject(main_container)
