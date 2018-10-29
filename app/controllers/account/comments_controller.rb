class Account::CommentsController < Account::AccountController
  before_action :load_commentable

  def create
    @comments = @commentable.comments.order_desc.page(params[:page]).per(5)
    @comment = @comments.build(comments_params)
    respond_to do |format|
      if @comment.save
        @comments = @commentable.comments.order_desc.page(params[:page]).per(5)
        flash[:notice] = 'Your comment was created'
        format.html { redirect_back fallback_location: root_path, notice: 'Your comment was saved' }
        format.js
      else
        flash[:alert] = 'Your comment was not created'
        format.html { redirect_back fallback_location: root_path, notice: @comment.errors.full_messages[0] }
        format.js
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path, notice: 'Your comment was deleted'
  end

  private

  def comments_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end

  def load_commentable
    resource, id = request.path.split('/')[2, 3]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
