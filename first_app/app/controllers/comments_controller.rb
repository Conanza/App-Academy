class CommentsController < ApplicationController
  def create
    user = user.find

    user.comment.create
    @comment = Comment.new(comment_params)
      Comment.new(body: "adsf")

    if params[:commentable_type] == User
      @user = User.find(params[:commentable_id])

      Comment.new(comment_params)

    elsif params[:contact_id]
      @contact = Contact.find(params[:contact_id])


    elsif params[:contact_share_id]

    end

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages,
                    status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    render json: @comment
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
end
