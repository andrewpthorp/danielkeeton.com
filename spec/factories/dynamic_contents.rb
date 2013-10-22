FactoryGirl.define do
  factory :dynamic_content do
    subject 'biography'
    content { Faker::Lorem.sentence(25) }

    factory :dynamic_content_with_region do
      region
    end
  end
end
