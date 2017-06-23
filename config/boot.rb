require 'dry-auto_inject'
require 'rom'

[
  '../../lib/railway_eng/persistence/repositories/**/*.rb',
].each do |path|
  Dir[File.expand_path(path, __FILE__)].each { |file| require file }
end

# Setup storage adapter
adapter = ROM.container(:sql, 'sqlite::memory') do |conf|
  conf.default.create_table(:blog_posts) do
    primary_key :id
    column :title, String, null: false
    column :body, String
    column :author, String
  end
end

# Setup IoC Container
main_container = Dry::Container.new
main_container.register(:adapter, adapter)
main_container.register(:blog_post_repo,
  RailwayEng::Persistence::Repositories::BlogPostRepo.new(adapter)
)
ImportMain = Dry::AutoInject(main_container)
