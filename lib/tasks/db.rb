require 'rom'
require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    ::ROM.container(:sql, 'sqlite::memory') do |conf|
      # NOP
    end
  end
end
