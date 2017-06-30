module PelitaExample
  class Application < Pelita::Application
    # Setup container
    require_relative 'container'

    # Load local libraries
    Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each { |f| require f }

    # Finalize container setup
    setting :container, Container
    PelitaExample::Container.finalize!
  end
end
