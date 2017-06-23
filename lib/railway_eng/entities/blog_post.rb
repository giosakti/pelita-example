module RailwayEng
  module Entities
    module Types
      include Dry::Types.module
    end

    class BlogPost < Dry::Struct
      constructor_type :schema

      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :body, Types::Strict::String
      attribute :author, Types::Strict::String
    end
  end
end
