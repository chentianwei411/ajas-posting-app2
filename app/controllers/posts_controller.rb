class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id desc").all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

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

  protected

  def post_params
    params.require(:post).permit(:content)
  end
end
