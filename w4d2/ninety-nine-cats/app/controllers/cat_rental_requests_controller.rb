class CatRentalRequestsController < ApplicationController

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end
  def new
    @cats = Cat.all
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      render json: @request
    else
      render(
        text: @request.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
