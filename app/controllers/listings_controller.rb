class ListingsController < ApplicationController

  def index
    @status = params[:status]

    unless Listing::VALID_STATES.include? @status
      render_404 and return
    end

    @listings = Listing.send(@status)
  end

  def show
    @listing = Listing.find(params[:id])
  end

end
