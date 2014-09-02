class MatchesController < ApplicationController
  inherit_resources
  actions :show

  before_action :correct_user

  protected
  
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to root_url unless current_user?(@user)
    end
end