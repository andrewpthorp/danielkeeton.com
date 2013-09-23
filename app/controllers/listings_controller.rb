class ListingsController < ApplicationController

  def index
    @status = params[:status]

    unless Listing::VALID_STATES.include? @status
      render_404 and return
    end

    case @status
    when 'for_sale'
      @listings = Listing.for_sale
    when 'for_rent'
      @listings = Listing.for_rent
    when 'under_contract'
      @listings = Listing.under_contract
    when 'sold'
      @listings = Listing.sold
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

end
