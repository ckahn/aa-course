class CommentsController < ApplicationController
  include ApplicationHelper
  include CommentsHelper

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
    render json: @comments
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    success?(@comment, :save)
  end

  def destroy
    @comment = Comment.find(params[:id])
    success?(@comment, :delete)
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
