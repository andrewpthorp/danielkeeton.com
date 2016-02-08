class HomeController < ApplicationController

  def index
    @testimonial = Testimonial.order('RANDOM()').first
    @post = Post.published.order("created_at DESC").first
    @biography = DynamicContent.content_for('biography', session[:region]).first
    @images = DynamicContent.content_for('image', session[:region])
  end

  def homeworth
  end

end
