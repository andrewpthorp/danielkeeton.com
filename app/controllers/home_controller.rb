class HomeController < ApplicationController

  def index
    @section = 'home'
    @featured_listing = Listing.featured.first
    @testimonial = Testimonial.first(order: "RANDOM()")
  end

  def homeworth
    flash[:success] = "Success! I have received your request and will get back to you shortly!"
    redirect_to root_path
  end

end
