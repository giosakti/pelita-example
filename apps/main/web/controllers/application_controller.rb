module Main
  Application.route do |r|
    r.multi_route

    r.get true do
      "Welcome from main"
    end
  end
end
