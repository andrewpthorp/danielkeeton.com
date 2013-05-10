# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    title Faker::Lorem.sentence(3)
    description Faker::Lorem.sentence(25)
    price 200000
    status 'for_sale'
    address_line_1 Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip Faker::Address.zip[0..5]

    factory :featured_listing do
      featured true
    end
  end
end
