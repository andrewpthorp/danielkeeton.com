class Admin::PostsController < Admin::BaseController

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update; end

  def new
    @post = Post.new
  end

  def create; end
  def destroy; end

end
