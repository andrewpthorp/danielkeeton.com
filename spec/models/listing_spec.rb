require 'spec_helper'

describe Listing do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:price) }

  describe '#callbacks' do
    describe '#ensure_single_featured' do
      it 'should not unset if the current Listing is not featured' do
        @featured = FactoryGirl.create(:featured_listing)
        @unfeatured = FactoryGirl.create(:listing)
        @featured.reload.should be_featured
      end

      it 'should unfeature all others if the current Listing is featured' do
        @first = FactoryGirl.create(:featured_listing)
        @second = FactoryGirl.create(:featured_listing)
        @first.reload.should_not be_featured
      end

      it 'should allow the first to be featured' do
        @first = FactoryGirl.create(:featured_listing)
        @first.should be_featured
      end

      it 'should not unfeature the current Listing' do
        @first = FactoryGirl.create(:featured_listing)
        @second = FactoryGirl.create(:featured_listing)
        @second.should be_featured
      end
    end
  end

  describe '#scopes' do
    describe '#featured' do
      it 'should only return featured Listings' do
        @featured = FactoryGirl.create(:featured_listing)
        @unfeatured = FactoryGirl.create(:listing)
        Listing.featured.should eq([@featured])
      end
    end
  end

  describe '#methods' do
  end

  describe '.methods' do
  end
end
