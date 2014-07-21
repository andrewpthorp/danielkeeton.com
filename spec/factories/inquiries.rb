# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inquiry do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    inquiry_type "homeworth"

    # Pass humanizer by default
    humanizer_question_id 0
    humanizer_answer "four"
  end
end
