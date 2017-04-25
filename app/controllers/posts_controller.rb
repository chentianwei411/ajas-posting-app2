class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id desc").limit(7)

    if params[:max_id]
      @posts = @posts.where("id < ?",params[:max_id])
    end

    respond_to do |format|
      format.html
      format.js   #如果客户端要求JavaScript,回传index.js.er
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    render :json => {:id => @post.id}
  end

  def like
    @post = Post.find(params[:id])
    if @post.find_like(current_user)
      return
    else
      @like = Like.new
      @like.user = current_user
      @like.post = @post
      @like.save
    end
    # 自动找like action 对应的文件like.js.erb。
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    render "like" #saf
  end

  def my_likes
    @posts = current_user.liked_posts
  end

  def collect
    @post = Post.find(params[:id])
    if @post.find_collect(current_user)
      return
    else
      @coll = Collection.new
      @coll.user = current_user
      @coll.post = @post
      @coll.save
    end

  end

  def uncollect
    @post = Post.find(params[:id])
    collect = @post.find_collect(current_user)
    collect.destroy
    render "collect"
  end

  def my_collections
    @posts = current_user.collected_posts
  end

  protected

  def post_params
    params.require(:post).permit(:content)
  end
end
