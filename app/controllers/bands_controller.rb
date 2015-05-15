  #     bands GET    /bands(.:format)           bands#index
  #           POST   /bands(.:format)           bands#create
  #  new_band GET    /bands/new(.:format)       bands#new
  # edit_band GET    /bands/:id/edit(.:format)  bands#edit
  #      band GET    /bands/:id(.:format)       bands#show
  #           PATCH  /bands/:id(.:format)       bands#update
  #           PUT    /bands/:id(.:format)       bands#update
  #           DELETE /bands/:id(.:format)       bands#destroy

class BandsController < ApplicationController
  before_action :require_log_in, except: :index

  def index
    @bands = Band.all

    render :index
  end

  def new
    @band = Band.new

    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      flash[:notices] = ["Band added!"]
      redirect_to bands_url
    else
      flash[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])

    render :edit
  end

  def update
    @band = Band.find(params[:id])

    if @band.update(band_params)
      flash[:notices] = ["Band updated!"]
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def show
    @band = Band.find(params[:id])
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    flash[:notices] = ["Band deleted!"]

    redirect_to bands_url
  end

  private

    def band_params
      params.require(:band).permit(:name)
    end
end