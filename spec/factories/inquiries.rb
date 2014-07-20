# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inquiry do
    name "MyString"
    email "MyString"
    phone "MyString"
    comments "MyText"
    address "MyString"
    square_footage "MyString"
    bathrooms "MyString"
    bedrooms "MyString"
    updates "MyText"
    inquiry_type "homeworth"
  end
end
