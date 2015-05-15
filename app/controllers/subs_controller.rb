class SubsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  # before_action :require_moderator

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      flash[:notices] = ["sub created"]
      redirect_to @sub
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      flash[:notices] = ["sub updated"]
      redirect_to @sub
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy

    redirect_to subs_url
  end

  private

    def sub_params
      params.require(:sub).permit(:title, :description, :moderator_id)
    end
end
