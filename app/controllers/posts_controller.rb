class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      flash[:notices] = ["post created"]
      redirect_to @post
    else
      @subs = Sub.all
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notices] = ["post updated"]
      redirect_to @post
    else
      @subs = Sub.all
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:title, :url, :content, :sub_id)
    end

    def require_author
      @post = Post.find(params[:id])
      return if current_user == @post.author
      flash[:notices] = ["you must be the author"]

      redirect_to @post
    end
end
