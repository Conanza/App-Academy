 # new_band_album GET    /bands/:band_id/albums/new(.:format)   albums#new
     #     albums POST   /albums(.:format)          albums#create
     # edit_album GET    /albums/:id/edit(.:format) albums#edit
     #      album GET    /albums/:id(.:format)      albums#show
     #            PATCH  /albums/:id(.:format)      albums#update
     #            PUT    /albums/:id(.:format)      albums#update
     #            DELETE /albums/:id(.:format)      albums#destroy

class AlbumsController < ApplicationController
  before_action :require_log_in

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    @bands = Band.all

    render :new
  end

  def create
    @album = Album.new(album_params)
    @bands = Band.all

    if @album.save
      flash[:notices] = ["Album added!"]

      redirect_to band_url(@album.band)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all

    render :edit
  end

  def update
    @album = Album.find(params[:id])
    @bands = Band.all

    if @album.update(album_params)
      flash[:notices] = ["Album successfully updated"]
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    @tracks = Track.includes(:album).where(album_id: @album.id)
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    flash[:notices] = ["Album deleted"]
    redirect_to bands_url
  end

  private

    def album_params
      params.require(:album).permit(:title, :album_type, :band_id)
    end
end