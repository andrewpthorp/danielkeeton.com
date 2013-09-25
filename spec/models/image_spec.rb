require 'spec_helper'

describe Image do

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:file) }
    it { should allow_mass_assignment_of(:primary) }
    it { should_not allow_mass_assignment_of(:listing) }
  end

  describe '.associations' do
    it { should belong_to(:listing) }
  end

  describe '.validations' do
    it { should validate_presence_of(:file) }
  end

  describe '.callbacks' do
    let (:listing) { FactoryGirl.create(:listing) }
    let (:image) { listing.images.first }

    describe '.unset_other_primary_images' do
      before do
        @primary = FactoryGirl.create(:primary_image, listing: listing)
      end

      it 'should run the callback before save' do
        image.should_receive(:unset_other_primary_images)
        image.run_callbacks(:save)
      end

      context 'when the image being saved is marked as primary' do
        it 'should unset primary on the listings primary image' do
          image.primary = true
          image.save
          expect(@primary.reload).not_to be_primary
        end

        it 'should leave the current image primary' do
          image.primary = true
          image.save
          expect(image).to be_primary
        end
      end

      context 'when the image being saved is not marked as primary' do
        it 'should not unset primary on the listings primary image' do
          image.primary = false
          image.save
          expect(@primary.reload).to be_primary
        end
      end
    end

    describe '.ensure_one_primary' do
      it 'should run the callback before save' do
        image.should_receive(:ensure_one_primary)
        image.run_callbacks(:save)
      end

      context 'when there are no other primary images for a listing' do
        it 'should set primary to true for the image being saved' do
          image.update_column(:primary, false)
          image.should_receive(:primary=).with(true)
          image.send(:ensure_one_primary)
        end
      end

      context 'when there are primary images for a listing' do
        it 'should not change primary for the image being saved' do
          FactoryGirl.create(:primary_image, listing: listing)
          image.should_not_receive(:primary=)
          image.send(:ensure_one_primary)
        end
      end
    end
  end

  describe '.scopes' do
    before do
      @listing = FactoryGirl.create(:listing_with_multiple_images)
    end

    describe '.for_listing' do
      it 'should return images for a given listing' do
        expect(Image.for_listing(@listing.id).to_a).to eq(@listing.images.to_a)
      end
    end

    describe '.primary' do
      it 'should return primary images' do
        expect(Image.primary).to eq(Image.where(primary: true))
      end
    end
  end

end
