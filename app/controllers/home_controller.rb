class HomeController < ApplicationController

  def index
    @section = 'home'
    @featured_listing = Listing.featured.first
    @testimonial = Testimonial.first(order: "RANDOM()")
  end

end
