module Main
  class Application < Roda
    use Rack::Session::Cookie, secret: "e52cc08a0ffbd0f4e68f705106f9a827be32681c42a2df89d12ea2fddd83790a6ebeb19acf06b946198b54cf653afe03218850f2ab79ac8d74d649395341f0eb", key: "_main_session"
    use Rack::Protection
    plugin :csrf
    plugin :multi_route

    # Register this app into root application
    PelitaExample::Application.run 'main', Main::Application

    # Load controllers
    Dir[File.expand_path('../../web/controllers/**/*.rb', __FILE__)].each { |f| require f }
  end
end
