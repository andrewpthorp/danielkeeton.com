module ListingsHelper

  def pretty_status(listing)
    case listing.status
    when 'for_sale'
      "(For Sale)"
    when 'for_rent'
      "(For Rent)"
    when 'under_contract'
      "(Under Contract)"
    when 'sold'
      "(Sold)"
    when 'cancelled'
      "(Cancelled)"
    end
  end

end
