class PostsController < ApplicationController

  def index
    @posts = Post.published
    @testimonials = Testimonial.all
  end

  def show
    @post = Post.find(params[:id])
  end

end
