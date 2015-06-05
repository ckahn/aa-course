class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :new
    else
      render text: "NOPE"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
