class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
      flash[:notice] = "Invalid login"
      redirect_to new_session_url
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
