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
