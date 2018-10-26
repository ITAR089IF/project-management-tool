class Account::CommentsController < Account::AccountController
  before_action :set_task

  def new
    @comment = @task.comments.new
  end

  def create
    @comment = @task.comments.new(comments_params)
    if @comment.save
        redirect_to account_project_task_path(@task.project, @task )
    else
      render :new
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to account_project_task_path(@task.project, @task )
  end

  private
  def set_comment
    @comment = @task.comments.find(params[:id])
  end


  def set_task
    @task = Task.find(params[:task_id])
  end

  def comments_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)

  end
end
