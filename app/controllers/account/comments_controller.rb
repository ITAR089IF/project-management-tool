class Account::CommentsController < Account::AccountController
  before_action :load_commentable

  def create
    @comments = @commentable.comments.order_desc
    @comment = @comments.build(comments_params)
    @comment.save
    respond_to :js
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comments = @commentable.comments.order_desc
    @comment.destroy
    respond_to :js
  end

  private

  def comments_params
    params.require(:comment).permit(:body).merge!(user: current_user)
  end

  def load_commentable
    resource, id = request.path.split('/')[2, 3]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
