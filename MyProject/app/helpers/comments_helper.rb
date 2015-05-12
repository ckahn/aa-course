module CommentsHelper
  private

  def comment_params
    params.require(:comment).permit(:author_id, :body)
  end
end
