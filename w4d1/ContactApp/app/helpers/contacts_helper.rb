module ContactsHelper
  private

  def contact_params
    params[:contact].permit(:user_id, :name, :email)
  end

end
