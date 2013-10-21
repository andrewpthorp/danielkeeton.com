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

    content_tag :dl, class: 'sub-nav' do
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
    regions = [
      ['Afton', '322'], ['Alberta', '484'], ['Amelia', '1058'], ['Amherst', '1096'],
      ['Ampthill', '1130'], ['Appomattox', '1402'], ['Ark', '1569'], ['Arvonia', '1736'],
      ['Ashland', '1810'], ['Aylett', '2233'], ['Barhamsville', '2568'], ['Basye', '2792'],
      ['Beaverdam', '3183'], ['Blackstone', '4305'], ['Bowling Green', '5161'],
      ['Boydton', '5210'], ['Boykins', '5223'], ['Bracey', '5246'], ['Branchville', '5359'],
      ['Brodnax', '5788'], ['Bruington', '6031'], ['Buckingham', '6171'], ['Buffalo Junction', '6261'],
      ['Bumpass', '6304'], ['Burgess', '6354'], ['Burkeville', '6377'], ['Capron', '7227'],
      ['Caret', '7282'], ['Caroline', '53850'], ['Carrollton', '7451'], ['Carrsville', '7457'],
      ['Carson', '7465'], ['Cartersville', '7489'], ['Center Cross', '7928'], ['Champlain', '8156'],
      ['Charles City', '8229'], ['Charles City Co.', '53851'], ['Charlotte', '53852'],
      ['Charlottesville', '8273'], ['Chase City', '8293'], ['Chesapeake', '8466'],
      ['Chester', '8501'], ['Chesterfield', '8521'], ['Church Road', '8755'], ['Clarksville', '8991'],
      ['Cobbs Creek', '9460'], ['Colonial Beach', '9769'], ['Colonial Heights', '9771'],
      ['Columbia', '9825'], ['Courtland', '10555'], ['Crewe', '10859'], ['Crozier', '11025'],
      ['Cullen', '11114'], ['Culpeper', '11124'], ['Cumberland', '11143'], ['Deltaville', '12002'],
      ['Dendron', '12021'], ['Dewitt', '12218'], ['Dillwyn', '12335'], ['Dinwiddie', '12355'],
      ['Disputanta', '12366'], ['Doswell', '12590'], ['Drakes Branch', '12723'],
      ['Drewryville', '12760'], ['Dundas', '12968'], ['Dunnsville', '13033'], ['Dutton', '13107'],
      ['Edinburg', '13922'], ['Emporia', '14658'], ['Essex', '53853'], ['Falmouth', '15612'],
      ['Farmville', '15713'], ['Farnham', '15718'], ['Floyd', '16271'], ['Fluvanna', '53855'],
      ['Ford', '16346'], ['Franklin', '16898'], ['Fredericksburg', '16964'], ['Gasburg', '17592'],
      ['Gladstone', '17995'], ['Glen Allen', '18043'], ['Gloucester', '18265'],
      ['Gloucester Point', '18267'], ['Goochland', '18400'], ['Gordonsville', '18496'],
      ['Green Bay', '18981'], ['Greenville', '19188'], ['Gretna', '19275'],
      ['Grimstead', '19314'], ['Gum Spring', '19495'], ['Gwynn', '19561'], ['Hadensville', '19627'],
      ['Hague', '19658'], ['Halifax', '19722'], ['Hallieford', '19744'], ['Hampden Sydney', '19880'],
      ['Hampton', '19903'], ['Hanover', '19990'], ['Hartfield', '20266'], ['Hayes', '20550'],
      ['Heathsville', '20672'], ['Henrico', '53748'], ['Highland Springs', '21182'],
      ['Honaker', '21725'], ['Hopewell', '21838'], ['Howardsville', '21995'], ['Hudgins', '22079'],
      ['Irvington', '22792'], ['Ivor', '22897'], ['Jamaica', '23005'], ['James City Co.', '53859'],
      ['Jarratt', '23156'], ['Jetersville', '23345'], ['Kenbridge', '23921'], ['Kents Store', '24040'],
      ['Keysville', '24152'], ['Kilmarnock', '24210'], ['King & Queen', '53860'], ['King George', '24270'],
      ['King William', '24275'], ['Kinsale', '24385'], ['La Crosse', '24735'], ['Ladysmith', '24912'],
      ['Lancaster', '25459'], ['Laneview', '25513'], ['Lanexa', '25515'], ['Lawrenceville', '25811'],
      ['Lexington', '26330'], ['Little Plymouth', '26752'], ['Locust Grove', '26937'],
      ['Locust Hill', '26940'], ['Louisa', '27322'], ['Lunenburg', '27583'],
      ['Maidens', '27984'], ['Manakin', '28086'], ['Manakin Sabot', '28087'],
      ['Mannboro', '28197'], ['Manquin', '28227'], ['Mathews', '28879'],
      ['Mattaponi', '28899'], ['Mc Kenney', '29203'], ['Meadowview', '29473'],
      ['Mechanicsville', '29504'], ['Meherrin', '29584'], ['Merry Point', '29828'],
      ['Middlesex', '53862'], ['Midlothian', '30084'], ['Milford', '30206'],
      ['Millers Tavern', '30285'], ['Mineral', '30476'], ['Monroe', '30833'],
      ['Montpelier', '30999'], ['Montross', '31025'], ['Moon', '31057'], ['Moseley', '31330'],
      ['Mount Holly', '31476'], ['Mount Jackson', '31492'], ['Nathalie', '32055'],
      ['Nelson', '32221'], ['New Canton', '32389'], ['New Kent', '32531'],
      ['Newport News', '32887'], ['Newsoms', '32894'], ['Newtown', '32935'],
      ['Norfolk', '33138'], ['North', '33191'], ['Northumberland', '53864'],
      ['Nottoway', '33768'], ['Oilville', '34227'], ['Orange', '34603'],
      ['Other', '73'], ['Palmyra', '35273'], ['Pamplin', '35302'], ['Partlow', '35661'],
      ['Petersburg', '36301'], ['Poquoson', '37373'], ['Port Haywood', '37416'],
      ['Port Royal', '37456'], ['Portsmouth', '37551'], ['Powhatan', '37676'],
      ['Prince Edward', '53866'], ['Prince George', '37870'], ['Providence Forge', '37988'],
      ['Quinton', '38246'], ['Rawlings', '38553'], ['Red Oak', '38718'], ['Reedville', '38841'],
      ['Rice', '39164'], ['Richmond', '39267'], ['Rockville', '39905'],
      ['Ruther Glen', '40626'], ['Saint Stephens Church', '41027'], ['Saluda', '41164'],
      ['Sandston', '41378'], ['Sandy Hook', '41406'], ['Sandy Point', '41414'],
      ['Saxe', '41673'], ['Scottsburg', '41876'], ['Scottsville', '41884'],
      ['Seaford', '41933'], ['Sedley', '42095'], ['Shacklefords', '42291'],
      ['Smithfield', '43265'], ['South Boston', '43577'], ['South Hill', '43703'],
      ['Spotsylvania', '44120'], ['Spring Grove', '44175'], ['Stevensville', '44685'],
      ['Stony Creek', '44870'], ['Suffolk', '45116'], ['Supply', '45421'],
      ['Surry', '45440'], ['Susan', '45443'], ['Sussex', '45450'],
      ['Sutherland', '45458'], ['Tappahannock', '45846'], ['Toano', '46525'],
      ['Topping', '46673'], ['Troy', '47008'], ['Urbanna', '48513'],
      ['Victoria', '49051'], ['Virginia Beach', '49410'], ['Wake', '49604'],
      ['Walkerton', '49704'], ['Warfield', '49936'], ['Warm Springs', '49947'],
      ['Warsaw', '50023'], ['Water View', '50132'], ['Waverly', '50308'],
      ['Weems', '50457'], ['West Point', '51043'], ['Wicomico', '51745'],
      ['Williamsburg', '51903'], ['Wilsons', '52086'], ['Windsor', '52185'],
      ['Wintergreen', '52311'], ['Woodford', '52515'], ['Yale', '52838'],
      ['Yorktown', '52968'], ['Zuni', '53118']
    ]

    unless session[:region].blank?
      selected_region = regions.select { |r| r[0].downcase == session[:region] }
      selected_region = selected_region.first[1] unless selected_region.empty?
    end

    options_for_select(regions, selected_region)
  end

end
