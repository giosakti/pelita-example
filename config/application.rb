class Application < Roda
  plugin :multi_run

  route do |r|
    r.multi_run
  end
end
