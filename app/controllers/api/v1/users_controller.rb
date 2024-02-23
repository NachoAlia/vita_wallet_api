class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:create]
    
    def create 
        user = User.new(user_params)
        if user.save
            render json: user, status: :created
        else 
            render json: user.errors, status: :unprocessable_entity
        end 
    end 

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end 
end 