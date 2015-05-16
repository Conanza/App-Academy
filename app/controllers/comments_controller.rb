class CommentsController < ApplicationController
  before_action :require_login

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:notices] = ["comment created"]
      redirect_to @comment.post
    else
      @post = @comment.post
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
end
