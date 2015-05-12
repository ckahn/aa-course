module UsersHelper
  private

  def user_params
    params[:user].permit(:username)
  end
end
