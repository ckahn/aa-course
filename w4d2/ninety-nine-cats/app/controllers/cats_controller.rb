class CatsController < ApplicationController
  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      flash[:notice] = "Cat created!"
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.cat_rental_requests.order(:start_date)
  end

  def new
    @cat = Cat.new
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date, :name, :color, :sex, :description)
  end
end
