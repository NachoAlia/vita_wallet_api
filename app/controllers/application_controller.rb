class ApplicationController < ActionController::API
    include ActionController::Helpers
    include ActionController::HttpAuthentication::Token::ControllerMethods
    
    before_action :authenticate_user!
    helper_method :current_user

    private

    def authenticate_user!
      authenticate_or_request_with_http_token do |token, options|
        User.find_by(token: token)
      end
    end

    def current_user
        token = request.headers['Authorization']&.split(' ')&.last
        @current_user ||= User.find_by(token: token)
    end
end
