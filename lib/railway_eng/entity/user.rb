module RailwayEng
  module Entity
    module Types
      include Pelita::Types.module
    end

    class User < Pelita::Entity::Base
      attribute :id, Types::Strict::Int
      attribute :username, Types::Strict::String
      attribute :signed_in, Types::Strict::Bool

      def signed_in?
        signed_in
      end
    end
  end
end
