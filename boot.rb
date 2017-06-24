require 'bundler'
Bundler.require

require_relative 'lib/base_operation'
require_relative 'lib/attempt_adapter'

# Setup storage adapter
adapter = ROM.container(:sql, 'sqlite::memory') do |conf|
  conf.default.create_table(:blog_posts) do
    primary_key :id
    column :title, String, null: false
    column :body, String
    column :author, String
  end
end

# Initialize IoC container
main_container = Dry::Container.new

## Register repositories
[
  '../lib/railway_eng/persistence/repository/**/*.rb',
].each do |path|
  Dir[File.expand_path(path, __FILE__)].each { |file| require file }
end

main_container.register(:adapter, adapter)
main_container.register(:blog_post_repo,
  RailwayEng::Persistence::Repository::BlogPostRepo.new(adapter)
)

# Make IoC container available
ImportMain = Dry::AutoInject(main_container)

# Boot other components
[
  '../lib/railway_eng/**/*.rb',
].each do |path|
  Dir[File.expand_path(path, __FILE__)].each { |file| require file }
end

require_relative 'config/application'

# Load sub-apps
app_paths = Pathname(__FILE__).dirname.join("apps").realpath.join("*")
Dir[app_paths].each do |f|
  require "#{f}/boot"
end
