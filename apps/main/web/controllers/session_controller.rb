module Main
  Application.route('session') do |r|
    r.get 'new' do
      "Login page"
    end
  end
end
