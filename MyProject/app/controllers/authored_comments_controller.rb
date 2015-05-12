class AuthoredCommentsController < ApplicationController
  def index
    @author = User.find(params[:user_id])
    @comments = @author.authored_comments
    render json: @comments
  end
end
