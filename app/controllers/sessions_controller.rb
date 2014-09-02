class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    
    session[:user_id] = user.id
    
    if has_matches?
      flash[:notice] = "Welcome back!"
      redirect_to user_path(user)
    else
      redirect_to edit_user_path(user)
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  protected
  
    def auth_hash
      request.env['omniauth.auth']
    end
end