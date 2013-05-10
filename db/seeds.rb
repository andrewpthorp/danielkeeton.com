# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Destroying Testimonials"
Testimonial.destroy_all

puts "Loading Testimonials (5)"
Testimonial.create(body: "Daniel is one of the most honest individuals you will ever meet in a life time. He has a true heart for his customers and will strive to meet your every need.", name: "D. Walz")
Testimonial.create(body: "Hardworking and has your best interest at heart. Highly recommend using his services.", name: "A. McKinley")
Testimonial.create(body: "Daniel Keeton was a great realtor. He was helpful from beginning to end. Daniel was also available day or night for any questions I had. I would highly recommend him to anyone looking to buy a house.", name: "L. Gibson")
Testimonial.create(body: "Daniel was the best realtor we've had. We had constant traffic coming through looking at our house. He kept us informed throughout the whole process. I highly recommend Daniel.", name: "L. Birchfield")
Testimonial.create(body: "I want to say how much I enjoyed having Daniel Keeton represent me during my first real estate investment purchase. When I started thinking how I wanted to invest my money, I realized rental property may give me the best return on my investment with monthly income. Daniel is very excited about real estate and knowledgeable!  Whenever I saw a property I wanted to see, he was immediately available to show it. Every little detail from choosing the right house to closing the deal, Daniel was on it and assisted me through all the steps I needed to take once the contract was signed. I am so happy with Daniel, that I want to recommend him to anyone looking for a young, energetic and intelligent agent!", name: "W. R.")

puts "Destroying Listings"
Listing.destroy_all

puts "Loading Listings (20)"
FactoryGirl.create(:featured_listing, image: File.open(File.join(Rails.root, "/db/data/sample_house_one.jpg")))
FactoryGirl.create(:listing, image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'for_rent', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
FactoryGirl.create(:listing, status: 'sold', image: File.open(File.join(Rails.root, "/db/data/sample_house_one.jpg")))
FactoryGirl.create(:listing, status: 'sold', image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'under_contract', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
FactoryGirl.create(:listing, status: 'for_rent', image: File.open(File.join(Rails.root, "/db/data/sample_house_one.jpg")))
FactoryGirl.create(:listing, status: 'for_rent', image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'sold', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
FactoryGirl.create(:listing, status: 'sold', image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_one.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'for_rent', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
FactoryGirl.create(:listing, status: 'for_rent', image: File.open(File.join(Rails.root, "/db/data/sample_house_one.jpg")))
FactoryGirl.create(:listing, status: 'for_sale', image: File.open(File.join(Rails.root, "/db/data/sample_house_two.jpg")))
FactoryGirl.create(:listing, status: 'under_contract', image: File.open(File.join(Rails.root, "/db/data/sample_house_three.jpg")))
