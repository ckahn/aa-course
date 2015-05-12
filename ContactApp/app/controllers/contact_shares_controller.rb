class ContactSharesController < ApplicationController
  include ContactSharesHelper
  include ApplicationHelper

  def create
    @contact_share = ContactShare.new(contact_share_params)
    success?(@contact_share, :save)
  end

  def delete
    @contact_share = ContactShare.find(params[:id])
    render json: success?(@contact_share, :destroy)
  end
end
