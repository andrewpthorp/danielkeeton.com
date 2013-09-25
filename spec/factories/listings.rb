FactoryGirl.define do
  factory :listing do

    # Basic Listing Info
    title { Faker::Lorem.sentence(3) }
    description { Faker::Lorem.sentence(25) }
    price 200000
    status 'for_sale'

    # Address
    address_line_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip[0..5] }
    link { Faker::Internet.url }

    # Home Info
    bedrooms 1 + Random.rand(4)
    bathrooms 1 + Random.rand(3) + 0.5
    square_footage 1750
    lot_size 3450

    # Create an Image for the Listing
    after(:build) do |listing|
      listing.images << FactoryGirl.build(:image)
    end

    factory :featured_listing do
      featured true
    end

    factory :listing_with_multiple_images do
      after(:build) do |listing|
        listing.images << FactoryGirl.build(:image)
      end
    end
  end
end
