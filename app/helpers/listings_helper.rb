# Public: All helpers that are to be used for Listings are in here. Even though
# all helpers are application-wide, it makes sense to put them here for clarity.
module ListingsHelper

  # Public: Get the URL for a link to google maps with the address of a Listing.
  #
  # listing - The Listing to get the link for.
  #
  # Returns a String.
  def google_maps_address(listing)
    "http://maps.google.com/?q=#{listing.address_line_1}, #{listing.city}, #{listing.state}, #{listing.zip}"
  end

  # Public: Get the address of a Listing formatted for HTML.
  #
  # listing   - The Listing to format the address of.
  # opts      - The Hash of options to modify the result (default: {}).
  #             :p_class - The class to put on each paragraph tag.
  #
  # Returns an ActiveSupport::SafeBuffer.
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

  # Public: Get the subnav for Listing states. It will give us a definition list
  # using the foundation class 'sub-nav' and links to each visible state of
  # Listings in the site: for_sale, for_rent, under_contract, and sold.
  #
  # curr - The current state that we are looking at.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def listing_status_nav(curr)
    curr = 'for_sale' if curr.blank?

    items = [
      content_tag(:dt, 'View listings that are:'),
      content_tag(:dd, link_to('For Sale', listings_path), class: curr == 'for_sale' ? 'active' : ''),
      content_tag(:dd, link_to('For Rent', status_listings_path('for_rent')), class: curr == 'for_rent' ? 'active' : ''),
      content_tag(:dd, link_to('Under Contract', status_listings_path('under_contract')), class: curr == 'under_contract' ? 'active' : ''),
      content_tag(:dd, link_to('Sold', status_listings_path('sold')), class: curr == 'sold' ? 'active' : '')
    ]

    content_tag :dl, class: 'sub-nav listings' do
      items.map do |item|
        concat(item)
      end
    end
  end


  # Public: Get the gallery of thumbnails for all Images of a Listing. Each link
  # has a class of 'fancybox' and a rel of 'gallery' so we can use fancybox to
  # create a gallery for the Images.
  #
  # listing - The Listing to get an unordered list of image thumbnails.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def listing_gallery_thumbs(listing)
    return nil if listing.images.size <= 1
    items = []

    listing.images.each do |image|
      next if image.primary?
      items << link_to(image_tag(image.file.thumb), image.file.url,
                        class: 'fancybox', rel: 'gallery')
    end

    content_tag :ul, class: 'thumbnails' do
      items.map do |item|
        concat(content_tag(:li, item))
      end
    end
  end

  # Public: Get an Array of regions for local listings. I am not sure if these
  # are guaranteed to remain unchanged, so I will need to check into that.
  #
  # Returns an Array of Hashes.
  def local_listing_options
    regions = Region.all.map { |r| [r.name, r.idx_value] }

    unless session[:region].blank?
      selected_region = regions.select { |r| r[0].downcase == session[:region] }
      selected_region = selected_region.first[1] unless selected_region.empty?
    end

    options_for_select(regions, selected_region)
  end

end
