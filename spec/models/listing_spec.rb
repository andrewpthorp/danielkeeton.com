require 'spec_helper'

describe Listing do

  describe "#validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should ensure_inclusion_of(:status).in_array(Listing::VALID_STATES) }
    it { should validate_presence_of(:price) }

    it { should validate_presence_of(:bathrooms) }
    it { should validate_numericality_of(:bathrooms) }
    it { should_not allow_value(0).for(:bathrooms) }

    it { should validate_presence_of(:bedrooms) }
    it { should validate_numericality_of(:bedrooms).only_integer }
    it { should_not allow_value(0).for(:bedrooms) }

    it { should validate_numericality_of(:year_built) }
    it { should allow_value(1900).for(:year_built) }
    it { should allow_value(nil).for(:year_built) }
    it { should_not allow_value(1899).for(:year_built) }

    it { should validate_numericality_of(:square_footage) }
    it { should allow_value(nil).for(:square_footage) }
    it { should allow_value(1000).for(:square_footage) }
    it { should_not allow_value(999).for(:square_footage) }

    it { should validate_numericality_of(:lot_size) }
    it { should allow_value(nil).for(:lot_size) }
    it { should allow_value(1000).for(:lot_size) }
    it { should_not allow_value(999).for(:lot_size) }
  end

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
    before do
      @featured = FactoryGirl.create(:featured_listing, status: 'for_sale')
      @for_rent = FactoryGirl.create(:listing, status: 'for_rent')
      @under_contract = FactoryGirl.create(:listing, status: 'under_contract')
      @sold = FactoryGirl.create(:listing, status: 'sold')
    end

    describe '#featured' do
      it 'should only return featured Listings' do
        Listing.featured.should eq([@featured])
      end
    end

    describe '#for_sale' do
      it 'should only return Listings with a status of for_sale' do
        Listing.for_sale.should eq([@featured])
      end
    end

    describe '#for_rent' do
      it 'should only return Listings with a status of for_rent' do
        Listing.for_rent.should eq([@for_rent])
      end
    end

    describe '#under_contract' do
      it 'should only return Listings with a status of under_contract' do
        Listing.under_contract.should eq([@under_contract])
      end
    end

    describe '#sold' do
      it 'should only return Listings with a status of sold' do
        Listing.sold.should eq([@sold])
      end
    end
  end

  describe '#methods' do
  end

  describe '.methods' do
  end
end
