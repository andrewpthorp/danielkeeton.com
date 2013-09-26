FactoryGirl.define do
  factory :admin do
    email     { Faker::Internet.email }
    password  { 'abc12345678' }
  end
end
