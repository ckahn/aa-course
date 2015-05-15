class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:user][:email], password: params[:user][:password])
    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def delete
  end
end
