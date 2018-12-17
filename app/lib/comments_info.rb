class CommentsInfo
  def initialize(user)
    @user = user
    @projects = @user.available_projects
  end

  def report
    comments_info = []
    @projects.each do |project|
      comments_count = project.comments.where(user_id: @user).count
      comments_info.push( name: project.name, comments: comments_count )
    end
    comments_info
  end
end
