FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence(8) }
    body { "<p>#{Faker::Lorem.paragraphs(3).join('</p><p>')}</p>" }
    published false

    factory :published_post do
      published true
    end
  end
end
