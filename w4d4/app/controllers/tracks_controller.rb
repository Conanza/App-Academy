# new_album_track GET    /albums/:album_id/tracks/new(.:format) tracks#new
     #     tracks POST   /tracks(.:format)          tracks#create
     # edit_track GET    /tracks/:id/edit(.:format) tracks#edit
     #      track GET    /tracks/:id(.:format)      tracks#show
     #            PATCH  /tracks/:id(.:format)      tracks#update
     #            PUT    /tracks/:id(.:format)      tracks#update
     #            DELETE /tracks/:id(.:format)      tracks#destroy


class TracksController < ApplicationController
  before_action :require_log_in

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
    @albums = Album.all

    render :new
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all

    if @track.save
      flash[:notices] = ["Track added!!"]
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.where(band_id: @track.band.id)

    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      flash[:notices] = ["Track successfully updated!"]
      redirect_to track_url(@track)
    else
      @albums = Album.includes(:tracks).where(band_id: @track.band.id)
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
    render :show
  end

  def destroy
    @track = Track.find(params[:id])

    @track.destroy
    flash[:notices] = ["Track deleted"]

    redirect_to bands_url
  end

  private

    def track_params
      params.require(:track).permit(:song, :lyrics, :track_type, :album_id)
    end
end