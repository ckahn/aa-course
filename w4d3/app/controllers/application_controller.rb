class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :redirect_logged_in_user

  def current_user
    return nil if session[:session_token].nil?
    @user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in!
    @user.reset_session_token!
    session[:session_token] = @user.session_token
  end

  def redirect_logged_in_user
    if current_user
      redirect_to cats_url
    end
  end
end