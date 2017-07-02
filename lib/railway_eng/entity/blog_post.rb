module RailwayEng
  module Entity
    module Types
      include Pelita::Types.module
    end

    class BlogPost < Pelita::Entity::Base
      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :body, Types::Strict::String
      attribute :author, Types::Strict::String
    end
  end
end
