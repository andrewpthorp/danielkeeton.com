FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence(8) }
    body { Faker::Lorem.paragraphs(3).join("\n\n") }
    published false

    factory :published_post do
      published true
    end
  end
end
