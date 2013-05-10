class HomeController < ApplicationController

  def index
    @featured_listing = Listing.featured.first
  end

end
