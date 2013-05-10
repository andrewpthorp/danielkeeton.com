# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    title Faker::Lorem.sentence
    description Faker::Lorem.sentence(10)
    price 200000
    status 'available'

    factory :featured_listing do
      featured true
    end
  end
end
