module V1
  module User
    module Representer
      class Simple < Representable::Decorator
        include Representable::JSON

        property :id
        property :first_name
        property :last_name
        property :email
      end

      class List < Representable::Decorator
        include Representable::JSON::Collection

        items class: ::User, decorator: Simple
      end
    end
  end
end
