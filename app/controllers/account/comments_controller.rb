class Account::CommentsController < Account::AccountController
  def new
    @comment = parent_task.comments.new
  end

  def create
    if params.to_unsafe_h.keys.include?(:task_id)
      @comment = parent_task.comments.new(comments_params)
      if @comment.save
          redirect_back fallback_location: root_path
      else
        render :new
      end
    else
      @comment = parent_project.comments.new(comments_params)
      if @comment.save
          redirect_back fallback_location: root_path
      else
        render :new
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path
  end

  private
  def parent_task
    current_user.projects.find(params[:project_id]).tasks.find(params[:id])
  end

  def parent_project
    current_user.projects.find(params[:project_id])
  end

  def comments_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id )
  end
end
