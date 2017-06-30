module PelitaExample
  class Application < Pelita::Application
    # Setup container
    require_relative 'container'
    setting :container, Container
    Container.finalize!

    # Load local libraries
    Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each { |f| require f }

    # Load all repositories
    db = Container.resolve(:db)
    [
      RailwayEng::Persistence::Repository::BlogPostRepo,
    ].each do |repo|
      Container.register(
        repo.to_s.split('::').last.to_snake_case.to_sym,
        repo.new(db)
      )
    end
  end
end
