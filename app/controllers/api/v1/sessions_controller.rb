class Api::V1::SessionsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:create]
    include Auth
    def create 
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            token = Auth.generate_token(user.id)
            user.update_attribute(:token, token)
            render json: { user: user, token: token }, status: :created
        else 
            render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
        end 
    end 

    def destroy
        user = User.find_by(token: params[:token])
        if user
            user.update_attribute(:token, nil)
            render json: { message: 'Session destroyed' }, status: :no_content
        else
            render json: { error: 'Invalid token' }, status: :unprocessable_entity
        end
    end 
end 