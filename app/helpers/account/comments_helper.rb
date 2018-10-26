module Account::CommentsHelper
  def can_manage_comment?(comment)
    comment.user == current_user
  end
end
