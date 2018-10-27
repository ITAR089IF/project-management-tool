class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comments_params)
    if @comment.save
        redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: 'Something went wrong!'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def comments_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
