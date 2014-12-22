class CommentsController < ApplicationController

  before_action :authenticate, only: [:new, :create, :destroy]
  before_action :get_posts, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to :back, notice: 'Comment cant be blank.'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :parent_id)
  end

  def get_posts
    @post = Post.find(params[:post_id])
  end
end
