class PostsController < ApplicationController
  def index
    @section = 'posts'
    @posts = Post.published
  end

  def show
    @section = 'posts'
    @post = Post.find(params[:id])
  end
end
