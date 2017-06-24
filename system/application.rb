# Setup container first
require_relative 'container'

# Load local libraries
Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each { |f| require f }

# Finalize container setup
RopExample::Container.finalize!

module RopExample
  class Application < Roda
    extend Dry::Configurable

    setting :path, File.expand_path('')
    setting :container, Container

    plugin :multi_run
    route do |r|
      r.multi_run
    end
  end
end
