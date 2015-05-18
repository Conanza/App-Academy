class CommentsController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:notices] = ["comment created"]
      redirect_to @comment.post
    else
      @post = @comment.post
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id, :parent_comment_id)
    end
end
