class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    if @comment.save
        redirect_back fallback_location: root_path
    else
      flash[:alert] = 'Something went wrong!'
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path
  end

  private
  
  def comments_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id).
    merge(user_id: current_user.id)
  end
end
