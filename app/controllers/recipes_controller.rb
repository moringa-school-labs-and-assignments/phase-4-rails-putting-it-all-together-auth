class RecipesController < ApplicationController
    def index
        if logged_in?
          recipes = Recipe.includes(:user).all
          render json: recipes, include: { user: { only: [:id, :username, :image_url, :bio] } }, status: :ok
        else
          render json: { errors: ['Unauthorized'] }, status: :unauthorized
        end
    end      
  
    def create
        if logged_in?
          recipe = Recipe.new(recipe_params)
          recipe.user = current_user
          if recipe.save
            render json: recipe, include: { user: { only: [:id, :username, :image_url, :bio] } }, status: :created
          else
            render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: ['Unauthorized'] }, status: :unauthorized
        end
    end      
  
    private
  
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
      
end
  