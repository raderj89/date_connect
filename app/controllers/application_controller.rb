class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def has_matches?
    current_user.matches.count > 0
  end

  helper_method :has_matches?

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def signed_in?
    !current_user.nil?
  end

  helper_method :signed_in?

  def require_user_login!
    if current_user.nil?
      flash[:notice] = "You need to log in or sign up before continuing."
      redirect_to root_url
    end
  end

  helper_method :require_user_login!

  def current_user?(user)
    user == current_user
  end

  helper_method :current_user?
end
