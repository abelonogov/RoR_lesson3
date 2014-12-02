module CommentsHelper
  def user_can_delete_comment?(comment)
    comment.can_be_deleted? && comment.user == current_user
  end
end
