require 'bundler/setup'
require 'pelita/sql/rake_task'
require 'pelita/persistence/container'

namespace :db do
  task :setup do
    ::Pelita::Persistence.container(:sql, 'sqlite::memory') do |conf|
      # NOP
    end
  end
end
