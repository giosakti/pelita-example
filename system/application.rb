module RopExample
  class Application < Roda
    extend Dry::Configurable

    # Load or set initial configurations
    setting :root, File.expand_path('')
    setting :env, ENV['PELITA_ENV'] || 'development'

    # Setup container
    require_relative 'container'

    # Load local libraries
    Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each { |f| require f }

    # Finalize container setup
    RopExample::Container.finalize!
    setting :container, Container

    # Setup routing tree
    plugin :multi_run
    route do |r|
      r.multi_run
    end
  end
end
