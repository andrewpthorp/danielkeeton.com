class HomeController < ApplicationController

  def index
    @testimonial = Testimonial.order('RANDOM()').first
    @post = Post.published.order("created_at DESC").first
    @biography = DynamicContent.content_for('biography', session[:region]).first
    @images = DynamicContent.content_for('image', session[:region])
  end

  def homeworth
    Mailer.home_worth_email(params).deliver
    flash[:success] = "Success! I have received your request and will get back to you shortly!"
    redirect_to root_path
  end

  def contact
    Mailer.contact_email(params).deliver
    flash[:success] = "Success! I have received your email. Thanks!"
    redirect_to root_path
  end

end
