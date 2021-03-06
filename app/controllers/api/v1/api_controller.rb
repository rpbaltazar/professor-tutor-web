module Api::V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate

    protected

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, _options|
        @current_user = User.find_by(api_key: token)
      end
    end

    def render_unauthorized(realm = 'Application')
      headers['WWW-Authenticate'] = %(Token realm="#{realm.delete('"')}")
      render json: 'Bad credentials', status: :unauthorized
    end
  end
end
