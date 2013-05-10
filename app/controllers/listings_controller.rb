class ListingsController < ApplicationController

  def index
    @section = 'listings'
    @featured = Listing.featured.first
    @for_sale = Listing.for_sale
    @for_rent = Listing.for_rent
    @under_contract = Listing.under_contract
    @sold = Listing.sold
  end

end
