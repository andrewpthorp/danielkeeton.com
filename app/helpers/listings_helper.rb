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

  def google_maps_address(listing)
    "http://maps.google.com/?q=#{listing.address_line_1}, #{listing.city}, #{listing.state}, #{listing.zip}"
  end

  def pretty_address(listing, opts={})
    p_class = opts[:p_class] || "margin-bottom-5"

    content_tag(:div, class: "address") do
      root = []
      root << content_tag(:p, listing.address_line_1, class: p_class)
      root << content_tag(:p, listing.address_line_2, class: p_class) unless listing.address_line_2.nil?
      root << content_tag(:p, class: p_class) do
        elems = []
        elems << content_tag(:span, listing.city)
        elems << content_tag(:span, " #{listing.state}, ")
        elems << content_tag(:span, listing.zip)
        raw elems.join
      end
      raw root.join
    end
  end

end
