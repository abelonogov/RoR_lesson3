class CommentsController < ApplicationController

  before_action :authenticate, except: [:new, :create]

  def new
    @comment, @post_id = Comment.new, params[:post_id]
  end

  def create
    post = Post.find(params[:comment][:post_id])
    @comment = Comment.new(post_params)
    @comment.post = post
    if @comment.save
      redirect_to post_path(post), notice: 'Comment successfully added.'
    else
      redirect_to :back
    end
  end

  def post_params
    params.require(:comment).permit(:comment)
  end
end
