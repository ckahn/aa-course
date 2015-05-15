class AlbumsController < ApplicationController
  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url(@album.band)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "#{@album.name} was deleted"
    redirect_to band_url(@album.band)
  end

  def edit
    @album = Album.find(params[:id])
    @band  = @album.band
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    @band = Band.find(params[:band_id])
  end

  def show
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :live, :band_id)
  end
end
