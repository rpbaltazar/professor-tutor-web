module V1
  module User
    module Representer
      class Full < Simple
        include Representable::JSON

        property :api_key
        property :admin
        property :type, as: :user_type
      end
    end
  end
end
