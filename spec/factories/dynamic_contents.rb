FactoryGirl.define do
  factory :dynamic_content do
    title 'A Sample Biography'
    subject 'biography'
    content { Faker::Lorem.paragraphs(3).join("\n\n") }

    factory :dynamic_content_with_region do
      region
    end
  end
end
