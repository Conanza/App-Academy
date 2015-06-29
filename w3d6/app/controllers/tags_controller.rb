class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def index
    @tags = Tag.all
  end

  def destroy
    Tag.find(params[:id]).destroy

    flash.notice = "Tag deleteed!"

    redirect_to root_url
  end
end
