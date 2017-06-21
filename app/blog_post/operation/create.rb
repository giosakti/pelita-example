require "trailblazer/operation"

module BlogPost
  class Create < Trailblazer::Operation
    success :hello_world!
    step :how_are_you?
    success :enjoy_your_day!
    failure :tell_joke!

    def hello_world!(options, *)
      puts "Hello, Trailblazer!"
    end

    def how_are_you?(options, params:, **)
      puts "How are you?"
      params[:happy] == "yes"
    end

    def enjoy_your_day!(options, *)
      puts "Good to hear, have a nice day!"
    end

    def tell_joke!(options, *)
      options["joke"] = "Broken pencils are pointless."
    end
  end
end

