module RailwayEng
  module Concept
    module BlogPost
      module Contract
        Create = Pelita::Validation.Schema do
          input :hash?
          required(:title).filled(:str?)
          required(:body).maybe(min_size?: 9)
        end
      end
    end
  end
end
