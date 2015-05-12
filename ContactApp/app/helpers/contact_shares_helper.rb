module ContactSharesHelper
  private

  def contact_share_params
    params[:contact_share].permit(:user_id, :contact_id)
  end
end
