class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user][:email], params[:user][:password])
    if @user.save
      render :text, "saved"
    else
      render :text, "error"
    end
  end

  def show
  end

  def delete
  end
end
