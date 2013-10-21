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
  def local_listing_regions
    [
      { value: '322', name: 'Afton' },
      { value: '484', name: 'Alberta' },
      { value: '1058', name: 'Amelia' },
      { value: '1096', name: 'Amherst' },
      { value: '1130', name: 'Ampthill' },
      { value: '1402', name: 'Appomattox' },
      { value: '1569', name: 'Ark' },
      { value: '1736', name: 'Arvonia' },
      { value: '1810', name: 'Ashland' },
      { value: '2233', name: 'Aylett' },
      { value: '2568', name: 'Barhamsville' },
      { value: '2792', name: 'Basye' },
      { value: '3183', name: 'Beaverdam' },
      { value: '4305', name: 'Blackstone' },
      { value: '5161', name: 'Bowling Green' },
      { value: '5210', name: 'Boydton' },
      { value: '5223', name: 'Boykins' },
      { value: '5246', name: 'Bracey' },
      { value: '5359', name: 'Branchville' },
      { value: '5788', name: 'Brodnax' },
      { value: '6031', name: 'Bruington' },
      { value: '6171', name: 'Buckingham' },
      { value: '6261', name: 'Buffalo Junction' },
      { value: '6304', name: 'Bumpass' },
      { value: '6354', name: 'Burgess' },
      { value: '6377', name: 'Burkeville' },
      { value: '7227', name: 'Capron' },
      { value: '7282', name: 'Caret' },
      { value: '53850', name: 'Caroline' },
      { value: '7451', name: 'Carrollton' },
      { value: '7457', name: 'Carrsville' },
      { value: '7465', name: 'Carson' },
      { value: '7489', name: 'Cartersville' },
      { value: '7928', name: 'Center Cross' },
      { value: '8156', name: 'Champlain' },
      { value: '8229', name: 'Charles City' },
      { value: '53851', name: 'Charles City Co.' },
      { value: '53852', name: 'Charlotte' },
      { value: '8273', name: 'Charlottesville' },
      { value: '8293', name: 'Chase City' },
      { value: '8466', name: 'Chesapeake' },
      { value: '8501', name: 'Chester' },
      { value: '8521', name: 'Chesterfield' },
      { value: '8755', name: 'Church Road' },
      { value: '8991', name: 'Clarksville' },
      { value: '9460', name: 'Cobbs Creek' },
      { value: '9769', name: 'Colonial Beach' },
      { value: '9771', name: 'Colonial Heights' },
      { value: '9825', name: 'Columbia' },
      { value: '10555', name: 'Courtland' },
      { value: '10859', name: 'Crewe' },
      { value: '11025', name: 'Crozier' },
      { value: '11114', name: 'Cullen' },
      { value: '11124', name: 'Culpeper' },
      { value: '11143', name: 'Cumberland' },
      { value: '12002', name: 'Deltaville' },
      { value: '12021', name: 'Dendron' },
      { value: '12218', name: 'Dewitt' },
      { value: '12335', name: 'Dillwyn' },
      { value: '12355', name: 'Dinwiddie' },
      { value: '12366', name: 'Disputanta' },
      { value: '12590', name: 'Doswell' },
      { value: '12723', name: 'Drakes Branch' },
      { value: '12760', name: 'Drewryville' },
      { value: '12968', name: 'Dundas' },
      { value: '13033', name: 'Dunnsville' },
      { value: '13107', name: 'Dutton' },
      { value: '13922', name: 'Edinburg' },
      { value: '14658', name: 'Emporia' },
      { value: '53853', name: 'Essex' },
      { value: '15612', name: 'Falmouth' },
      { value: '15713', name: 'Farmville' },
      { value: '15718', name: 'Farnham' },
      { value: '16271', name: 'Floyd' },
      { value: '53855', name: 'Fluvanna' },
      { value: '16346', name: 'Ford' },
      { value: '16898', name: 'Franklin' },
      { value: '16964', name: 'Fredericksburg' },
      { value: '17592', name: 'Gasburg' },
      { value: '17995', name: 'Gladstone' },
      { value: '18043', name: 'Glen Allen' },
      { value: '18265', name: 'Gloucester' },
      { value: '18267', name: 'Gloucester Point' },
      { value: '18400', name: 'Goochland' },
      { value: '18496', name: 'Gordonsville' },
      { value: '18981', name: 'Green Bay' },
      { value: '19188', name: 'Greenville' },
      { value: '19275', name: 'Gretna' },
      { value: '19314', name: 'Grimstead' },
      { value: '19495', name: 'Gum Spring' },
      { value: '19561', name: 'Gwynn' },
      { value: '19627', name: 'Hadensville' },
      { value: '19658', name: 'Hague' },
      { value: '19722', name: 'Halifax' },
      { value: '19744', name: 'Hallieford' },
      { value: '19880', name: 'Hampden Sydney' },
      { value: '19903', name: 'Hampton' },
      { value: '19990', name: 'Hanover' },
      { value: '20266', name: 'Hartfield' },
      { value: '20550', name: 'Hayes' },
      { value: '20672', name: 'Heathsville' },
      { value: '53748', name: 'Henrico' },
      { value: '21182', name: 'Highland Springs' },
      { value: '21725', name: 'Honaker' },
      { value: '21838', name: 'Hopewell' },
      { value: '21995', name: 'Howardsville' },
      { value: '22079', name: 'Hudgins' },
      { value: '22792', name: 'Irvington' },
      { value: '22897', name: 'Ivor' },
      { value: '23005', name: 'Jamaica' },
      { value: '53859', name: 'James City Co.' },
      { value: '23156', name: 'Jarratt' },
      { value: '23345', name: 'Jetersville' },
      { value: '23921', name: 'Kenbridge' },
      { value: '24040', name: 'Kents Store' },
      { value: '24152', name: 'Keysville' },
      { value: '24210', name: 'Kilmarnock' },
      { value: '53860', name: 'King & Queen' },
      { value: '24270', name: 'King George' },
      { value: '24275', name: 'King William' },
      { value: '24385', name: 'Kinsale' },
      { value: '24735', name: 'La Crosse' },
      { value: '24912', name: 'Ladysmith' },
      { value: '25459', name: 'Lancaster' },
      { value: '25513', name: 'Laneview' },
      { value: '25515', name: 'Lanexa' },
      { value: '25811', name: 'Lawrenceville' },
      { value: '26330', name: 'Lexington' },
      { value: '26752', name: 'Little Plymouth' },
      { value: '26937', name: 'Locust Grove' },
      { value: '26940', name: 'Locust Hill' },
      { value: '27322', name: 'Louisa' },
      { value: '27583', name: 'Lunenburg' },
      { value: '27984', name: 'Maidens' },
      { value: '28086', name: 'Manakin' },
      { value: '28087', name: 'Manakin Sabot' },
      { value: '28197', name: 'Mannboro' },
      { value: '28227', name: 'Manquin' },
      { value: '28879', name: 'Mathews' },
      { value: '28899', name: 'Mattaponi' },
      { value: '29203', name: 'Mc Kenney' },
      { value: '29473', name: 'Meadowview' },
      { value: '29504', name: 'Mechanicsville' },
      { value: '29584', name: 'Meherrin' },
      { value: '29828', name: 'Merry Point' },
      { value: '53862', name: 'Middlesex' },
      { value: '30084', name: 'Midlothian' },
      { value: '30206', name: 'Milford' },
      { value: '30285', name: 'Millers Tavern' },
      { value: '30476', name: 'Mineral' },
      { value: '30833', name: 'Monroe' },
      { value: '30999', name: 'Montpelier' },
      { value: '31025', name: 'Montross' },
      { value: '31057', name: 'Moon' },
      { value: '31330', name: 'Moseley' },
      { value: '31476', name: 'Mount Holly' },
      { value: '31492', name: 'Mount Jackson' },
      { value: '32055', name: 'Nathalie' },
      { value: '32221', name: 'Nelson' },
      { value: '32389', name: 'New Canton' },
      { value: '32531', name: 'New Kent' },
      { value: '32887', name: 'Newport News' },
      { value: '32894', name: 'Newsoms' },
      { value: '32935', name: 'Newtown' },
      { value: '33138', name: 'Norfolk' },
      { value: '33191', name: 'North' },
      { value: '53864', name: 'Northumberland' },
      { value: '33768', name: 'Nottoway' },
      { value: '34227', name: 'Oilville' },
      { value: '34603', name: 'Orange' },
      { value: '73', name: 'Other' },
      { value: '35273', name: 'Palmyra' },
      { value: '35302', name: 'Pamplin' },
      { value: '35661', name: 'Partlow' },
      { value: '36301', name: 'Petersburg' },
      { value: '37373', name: 'Poquoson' },
      { value: '37416', name: 'Port Haywood' },
      { value: '37456', name: 'Port Royal' },
      { value: '37551', name: 'Portsmouth' },
      { value: '37676', name: 'Powhatan' },
      { value: '53866', name: 'Prince Edward' },
      { value: '37870', name: 'Prince George' },
      { value: '37988', name: 'Providence Forge' },
      { value: '38246', name: 'Quinton' },
      { value: '38553', name: 'Rawlings' },
      { value: '38718', name: 'Red Oak' },
      { value: '38841', name: 'Reedville' },
      { value: '39164', name: 'Rice' },
      { value: '39267', name: 'Richmond' },
      { value: '39905', name: 'Rockville' },
      { value: '40626', name: 'Ruther Glen' },
      { value: '41027', name: 'Saint Stephens Church' },
      { value: '41164', name: 'Saluda' },
      { value: '41378', name: 'Sandston' },
      { value: '41406', name: 'Sandy Hook' },
      { value: '41414', name: 'Sandy Point' },
      { value: '41673', name: 'Saxe' },
      { value: '41876', name: 'Scottsburg' },
      { value: '41884', name: 'Scottsville' },
      { value: '41933', name: 'Seaford' },
      { value: '42095', name: 'Sedley' },
      { value: '42291', name: 'Shacklefords' },
      { value: '43265', name: 'Smithfield' },
      { value: '43577', name: 'South Boston' },
      { value: '43703', name: 'South Hill' },
      { value: '44120', name: 'Spotsylvania' },
      { value: '44175', name: 'Spring Grove' },
      { value: '44685', name: 'Stevensville' },
      { value: '44870', name: 'Stony Creek' },
      { value: '45116', name: 'Suffolk' },
      { value: '45421', name: 'Supply' },
      { value: '45440', name: 'Surry' },
      { value: '45443', name: 'Susan' },
      { value: '45450', name: 'Sussex' },
      { value: '45458', name: 'Sutherland' },
      { value: '45846', name: 'Tappahannock' },
      { value: '46525', name: 'Toano' },
      { value: '46673', name: 'Topping' },
      { value: '47008', name: 'Troy' },
      { value: '48513', name: 'Urbanna' },
      { value: '49051', name: 'Victoria' },
      { value: '49410', name: 'Virginia Beach' },
      { value: '49604', name: 'Wake' },
      { value: '49704', name: 'Walkerton' },
      { value: '49936', name: 'Warfield' },
      { value: '49947', name: 'Warm Springs' },
      { value: '50023', name: 'Warsaw' },
      { value: '50132', name: 'Water View' },
      { value: '50308', name: 'Waverly' },
      { value: '50457', name: 'Weems' },
      { value: '51043', name: 'West Point' },
      { value: '51745', name: 'Wicomico' },
      { value: '51903', name: 'Williamsburg' },
      { value: '52086', name: 'Wilsons' },
      { value: '52185', name: 'Windsor' },
      { value: '52311', name: 'Wintergreen' },
      { value: '52515', name: 'Woodford' },
      { value: '52838', name: 'Yale' },
      { value: '52968', name: 'Yorktown' },
      { value: '53118', name: 'Zuni' }
    ]
  end

end
