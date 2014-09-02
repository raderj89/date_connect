class FavoritesController < ApplicationController
  inherit_resources
  before_action :load_user
  before_action :load_favorites, only: :index

  def index
    render :index, locals: {matches: @favorites} 
  end

  def create
    @favorite = @user.favorites.build(match_id: params["match_id"])
    if @favorite.save
      render json: {favorite_id: @favorite.id}
    end
  end

  def destroy
    @favorite = @user.favorites.find_by(id: params[:id]) unless @user.favorites.nil?
    if @favorite.destroy
      render text: 'destroyed'
    end
  end

  private
    def load_user
      @user = User.find_by_id(params[:user_id])
    end

    def load_favorites
      @favorites = @user.favorites.map do |favorite|
        Match.find_by_id(favorite.match_id)
      end
    end
end