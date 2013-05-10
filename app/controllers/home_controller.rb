class HomeController < ApplicationController

  def index
    @featured_listing = Listing.featured.first
    @testimonial = Testimonial.first(order: "RANDOM()")
  end

end
