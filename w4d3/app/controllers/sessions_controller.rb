class SessionsController < ApplicationController
  before_action :redirect_logged_in_user, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user
      log_in!
      redirect_to cats_url
    else
      flash.now[:notice] = "This account does not exist"
      @user = User.new(user_name: params[:user][:user_name])
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end
end
