class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
      
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          render json: { id: user.id, username: user.username, image_url: user.image_url, bio: user.bio }, status: :ok
        else
          render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end
      
    def destroy
        if logged_in?
          session.delete(:user_id)
          head :no_content
        else
          render json: { errors: ["Unauthorized"] }, status: :unauthorized
        end
    end

    private
  
    def logged_in?
      session[:user_id].present?
    end
end
  