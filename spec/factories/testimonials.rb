# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :testimonial do
    body Faker::Lorem.sentence(40)
    name Faker::Name.name
  end
end
