module ListingsHelper

  def pretty_status(listing)
    return "" if listing.available?
  end

end
