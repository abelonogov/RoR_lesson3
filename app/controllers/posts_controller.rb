class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :votes]
  before_action :authenticate, except: [:index, :show]
  before_action :set_cookie

  # GET /posts
  def index
    @posts = if params[:popular].present?
      Post.all.popular
    elsif params[:updated].present?
      Post.all.last_updated
    else
      Post.all.newest
    end
    respond_to do |format|
      format.json { render json: @posts, except: [:updated_at, :user_id], include: { user: { only: :name } } }
      format.html
    end
  end

  # GET /posts/1
  def show
    respond_to do |format|
      format.json { render json: @post, except: [:updated_at, :user_id], include: { user: { only: :name } } }
      format.html
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def votes
    if params[:vote] === 'positive'
      @post.voted_rate += 1
    elsif params[:vote] === 'negative'
      @post.voted_rate -= 1
    end
    save_voted_post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body, :tags)
    end

    def set_cookie
      cookies[:views] = cookies[:views].present? ? cookies[:views].to_i + 1 : 1
    end

    def save_voted_post
      voted_post = VotedPost.new(user: current_user, post: @post)
      if voted_post.valid? && @post.valid?
        voted_post.save
        @post.save
        respond_to do |format|
          format.js
        end
      else
        redirect_to :back
      end
    end
end