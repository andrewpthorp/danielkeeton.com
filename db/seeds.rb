if Rails.env.development?
  puts 'Destroying Testimonials'
  Testimonial.destroy_all

  puts 'Loading Testimonials (5)'
  5.times do
    FactoryGirl.create(:testimonial)
  end

  puts 'Destroying Listings'
  Listing.destroy_all

  puts 'Loading Listings (20)'
  20.times do
    FactoryGirl.create(:listing, status: %w(for_rent for_sale sold under_contract).sample)
  end
  puts 'Featuring Listing (1)'
  Listing.all.sample.update_column(:featured, true)

  puts 'Destroying Posts'
  Post.destroy_all

  puts 'Loading Posts (5)'
  5.times do
    FactoryGirl.create(:published_post)
  end

  puts 'Destroying Biographies'
  DynamicContent.destroy_all
  puts 'Creating Biographies (1)'
  FactoryGirl.create(:dynamic_content)
end


puts 'Destroying Regions'
Region.destroy_all
puts 'Loading Regions (240)'
[
  ['Afton', '322'], ['Alberta', '484'], ['Amelia', '1058'], ['Amherst', '1096'], ['Ampthill', '1130'], ['Appomattox', '1402'], ['Ark', '1569'], ['Arvonia', '1736'],
  ['Ashland', '1810'], ['Aylett', '2233'], ['Barhamsville', '2568'], ['Basye', '2792'], ['Beaverdam', '3183'], ['Blackstone', '4305'], ['Bowling Green', '5161'],
  ['Boydton', '5210'], ['Boykins', '5223'], ['Bracey', '5246'], ['Branchville', '5359'], ['Brodnax', '5788'], ['Bruington', '6031'], ['Buckingham', '6171'], ['Buffalo Junction', '6261'],
  ['Bumpass', '6304'], ['Burgess', '6354'], ['Burkeville', '6377'], ['Capron', '7227'], ['Caret', '7282'], ['Caroline', '53850'], ['Carrollton', '7451'], ['Carrsville', '7457'],
  ['Carson', '7465'], ['Cartersville', '7489'], ['Center Cross', '7928'], ['Champlain', '8156'], ['Charles City', '8229'], ['Charles City Co.', '53851'], ['Charlotte', '53852'],
  ['Charlottesville', '8273'], ['Chase City', '8293'], ['Chesapeake', '8466'], ['Chester', '8501'], ['Chesterfield', '8521'], ['Church Road', '8755'], ['Clarksville', '8991'],
  ['Cobbs Creek', '9460'], ['Colonial Beach', '9769'], ['Colonial Heights', '9771'], ['Columbia', '9825'], ['Courtland', '10555'], ['Crewe', '10859'], ['Crozier', '11025'],
  ['Cullen', '11114'], ['Culpeper', '11124'], ['Cumberland', '11143'], ['Deltaville', '12002'], ['Dendron', '12021'], ['Dewitt', '12218'], ['Dillwyn', '12335'], ['Dinwiddie', '12355'],
  ['Disputanta', '12366'], ['Doswell', '12590'], ['Drakes Branch', '12723'], ['Drewryville', '12760'], ['Dundas', '12968'], ['Dunnsville', '13033'], ['Dutton', '13107'],
  ['Edinburg', '13922'], ['Emporia', '14658'], ['Essex', '53853'], ['Falmouth', '15612'], ['Farmville', '15713'], ['Farnham', '15718'], ['Floyd', '16271'], ['Fluvanna', '53855'],
  ['Ford', '16346'], ['Franklin', '16898'], ['Fredericksburg', '16964'], ['Gasburg', '17592'], ['Gladstone', '17995'], ['Glen Allen', '18043'], ['Gloucester', '18265'],
  ['Gloucester Point', '18267'], ['Goochland', '18400'], ['Gordonsville', '18496'],  ['Green Bay', '18981'], ['Greenville', '19188'], ['Gretna', '19275'],
  ['Grimstead', '19314'], ['Gum Spring', '19495'], ['Gwynn', '19561'], ['Hadensville', '19627'], ['Hague', '19658'], ['Halifax', '19722'], ['Hallieford', '19744'], ['Hampden Sydney', '19880'],
  ['Hampton', '19903'], ['Hanover', '19990'], ['Hartfield', '20266'], ['Hayes', '20550'], ['Heathsville', '20672'], ['Henrico', '53748'], ['Highland Springs', '21182'],
  ['Honaker', '21725'], ['Hopewell', '21838'], ['Howardsville', '21995'], ['Hudgins', '22079'], ['Irvington', '22792'], ['Ivor', '22897'], ['Jamaica', '23005'], ['James City Co.', '53859'],
  ['Jarratt', '23156'], ['Jetersville', '23345'], ['Kenbridge', '23921'], ['Kents Store', '24040'], ['Keysville', '24152'], ['Kilmarnock', '24210'], ['King & Queen', '53860'], ['King George', '24270'],
  ['King William', '24275'], ['Kinsale', '24385'], ['La Crosse', '24735'], ['Ladysmith', '24912'], ['Lancaster', '25459'], ['Laneview', '25513'], ['Lanexa', '25515'], ['Lawrenceville', '25811'],
  ['Lexington', '26330'], ['Little Plymouth', '26752'], ['Locust Grove', '26937'], ['Locust Hill', '26940'], ['Louisa', '27322'], ['Lunenburg', '27583'], ['Maidens', '27984'], ['Manakin', '28086'], ['Manakin Sabot', '28087'],
  ['Mannboro', '28197'], ['Manquin', '28227'], ['Mathews', '28879'], ['Mattaponi', '28899'], ['Mc Kenney', '29203'], ['Meadowview', '29473'], ['Mechanicsville', '29504'], ['Meherrin', '29584'], ['Merry Point', '29828'],
  ['Middlesex', '53862'], ['Midlothian', '30084'], ['Milford', '30206'], ['Millers Tavern', '30285'], ['Mineral', '30476'], ['Monroe', '30833'], ['Montpelier', '30999'], ['Montross', '31025'], ['Moon', '31057'], ['Moseley', '31330'],
  ['Mount Holly', '31476'], ['Mount Jackson', '31492'], ['Nathalie', '32055'], ['Nelson', '32221'], ['New Canton', '32389'], ['New Kent', '32531'], ['Newport News', '32887'], ['Newsoms', '32894'], ['Newtown', '32935'],
  ['Norfolk', '33138'], ['North', '33191'], ['Northumberland', '53864'], ['Nottoway', '33768'], ['Oilville', '34227'], ['Orange', '34603'], ['Other', '73'], ['Palmyra', '35273'], ['Pamplin', '35302'], ['Partlow', '35661'],
  ['Petersburg', '36301'], ['Poquoson', '37373'], ['Port Haywood', '37416'], ['Port Royal', '37456'], ['Portsmouth', '37551'], ['Powhatan', '37676'], ['Prince Edward', '53866'], ['Prince George', '37870'], ['Providence Forge', '37988'],
  ['Quinton', '38246'], ['Rawlings', '38553'], ['Red Oak', '38718'], ['Reedville', '38841'], ['Rice', '39164'], ['Richmond', '39267'], ['Rockville', '39905'], ['Ruther Glen', '40626'], ['Saint Stephens Church', '41027'], ['Saluda', '41164'],
  ['Sandston', '41378'], ['Sandy Hook', '41406'], ['Sandy Point', '41414'], ['Saxe', '41673'], ['Scottsburg', '41876'], ['Scottsville', '41884'], ['Seaford', '41933'], ['Sedley', '42095'], ['Shacklefords', '42291'],
  ['Smithfield', '43265'], ['South Boston', '43577'], ['South Hill', '43703'], ['Spotsylvania', '44120'], ['Spring Grove', '44175'], ['Stevensville', '44685'], ['Stony Creek', '44870'], ['Suffolk', '45116'], ['Supply', '45421'],
  ['Surry', '45440'], ['Susan', '45443'], ['Sussex', '45450'], ['Sutherland', '45458'], ['Tappahannock', '45846'], ['Toano', '46525'], ['Topping', '46673'], ['Troy', '47008'], ['Urbanna', '48513'],
  ['Victoria', '49051'], ['Virginia Beach', '49410'], ['Wake', '49604'],  ['Walkerton', '49704'], ['Warfield', '49936'], ['Warm Springs', '49947'], ['Warsaw', '50023'], ['Water View', '50132'], ['Waverly', '50308'],
  ['Weems', '50457'], ['West Point', '51043'], ['Wicomico', '51745'], ['Williamsburg', '51903'], ['Wilsons', '52086'], ['Windsor', '52185'], ['Wintergreen', '52311'], ['Woodford', '52515'], ['Yale', '52838'],
  ['Yorktown', '52968'], ['Zuni', '53118']
].each do |region|
  Region.create(name: region[0], idx_value: region[1], slug: region[0].downcase.split.join(''))
end

puts 'Linking Regions (2)'
Region.where(name: 'Richmond').first.update_attributes(linkable: true)
Region.where(name: 'Goochland').first.update_attributes(linkable: true)
