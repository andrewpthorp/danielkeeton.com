FactoryGirl.define do
  factory :image do
    file { File.open(Dir.glob(File.join(Rails.root, 'lib', 'assets', 'images', 'listings', '*')).sample) }

    factory :primary_image do
      primary true
    end
  end
end
