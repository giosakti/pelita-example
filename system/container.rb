require 'dry/system/container'

module RopExample
  class Container < Dry::System::Container
    configure do |config|
    end

    Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each { |f| require f }
  end
end