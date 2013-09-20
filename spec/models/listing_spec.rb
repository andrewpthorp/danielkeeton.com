require 'spec_helper'

describe Listing do

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:status) }
    it { should allow_mass_assignment_of(:price) }
    it { should allow_mass_assignment_of(:featured) }
    it { should allow_mass_assignment_of(:link) }
    it { should allow_mass_assignment_of(:address_line_1) }
    it { should allow_mass_assignment_of(:address_line_2) }
    it { should allow_mass_assignment_of(:city) }
    it { should allow_mass_assignment_of(:state) }
    it { should allow_mass_assignment_of(:zip) }
    it { should allow_mass_assignment_of(:bedrooms) }
    it { should allow_mass_assignment_of(:bathrooms) }
    it { should allow_mass_assignment_of(:year_built) }
    it { should allow_mass_assignment_of(:square_footage) }
    it { should allow_mass_assignment_of(:lot_size) }
    it { should allow_mass_assignment_of(:image) }
  end

  describe '.validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:bathrooms) }
    it { should validate_presence_of(:bedrooms) }
    it { should ensure_inclusion_of(:status).in_array(Listing::VALID_STATES) }
    it { should validate_numericality_of(:bathrooms) }
    it { should_not allow_value(0).for(:bathrooms) }
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

  describe '.callbacks' do
    describe '.ensure_single_featured' do
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

  describe '.scopes' do
    describe '.featured' do
      let (:hash) { Listing.featured.where_values_hash }

      it 'should only return featured Listings' do
        expect(hash).to eq({'featured' => true})
      end
    end

    Listing::VALID_STATES.each do |status|
      describe ".#{status}" do
        let(:hash) { Listing.send(status.to_sym).where_values_hash }

        it "should only return listings with a status of #{status}" do
          expect(hash).to eq('status' => status)
        end
      end
    end
  end
end
