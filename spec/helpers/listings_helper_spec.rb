require 'spec_helper'

describe ListingsHelper do

  describe '#google_maps_address' do
    it 'should return the correct url' do
      opts = { address_line_1: '1', city: '2', state: '3', zip: '4' }
      listing = FactoryGirl.create(:listing, opts)
      expect(helper.google_maps_address(listing)).to eq(
        'http://maps.google.com/?q=1, 2, 3, 4'
      )
    end
  end

  describe '#pretty_address' do
    it 'should be tested' do
      pending 'need to refactor'
    end
  end

  describe '#listing_status_nav' do
    it 'should return a definition list' do
      expect(helper.listing_status_nav('')).to have_selector('dl.sub-nav.listings')
    end

    it 'should have a title' do
      expect(helper.listing_status_nav('')).to have_selector('dt', text: /View/)
    end

    it 'should have 4 links' do
      expect(helper.listing_status_nav('')).to have_selector('a', count: 4)
    end

    context 'when passing the current status in' do
      context 'and the current status is blank' do
        it 'should set the active link to for_sale' do
          results = helper.listing_status_nav('')
          expect(results).to have_selector('dd.active', text: 'For Sale')
        end
      end

      context 'and the current status is for_sale' do
        it 'should set the active link to for_sale' do
          results = helper.listing_status_nav('for_sale')
          expect(results).to have_selector('dd.active', text: 'For Sale')
        end
      end

      context 'and the current status is for_rent' do
        it 'should set the active link to for_rent' do
          results = helper.listing_status_nav('for_rent')
          expect(results).to have_selector('dd.active', text: 'For Rent')
        end
      end

      context 'and the current status is under_contract' do
        it 'should set the active link to under_contract' do
          results = helper.listing_status_nav('under_contract')
          expect(results).to have_selector('dd.active', text: 'Under Contract')
        end
      end

      context 'and the current status is sold' do
        it 'should set the active link to sold' do
          results = helper.listing_status_nav('sold')
          expect(results).to have_selector('dd.active', text: 'Sold')
        end
      end
    end
  end

  describe '#listing_gallery_thumbs' do
    let(:listing) { FactoryGirl.create(:listing_with_multiple_images) }
    let(:results) { helper.listing_gallery_thumbs(listing) }

    it 'should return an unordered list' do
      expect(results).to have_selector('ul.thumbnails')
    end

    it 'should return a list item for each image' do
      expect(results).to have_selector('li a.fancybox',
                                       count: listing.images.size - 1)
    end

    context 'when the listing only has one image' do
      it 'should return nil' do
        listing.stub_chain(:images, :size).and_return(1)
        expect(results).to be_nil
      end
    end

    context 'when the listing has no images' do
      it 'should return nil' do
        listing.stub_chain(:images, :size).and_return(0)
        expect(results).to be_nil
      end
    end
  end

  describe '#local_listing_options' do
    let (:results) { helper.local_listing_options }
    let! (:region) { FactoryGirl.create(:region) }

    it 'should have an option for each region' do
      expect(results).to(
        have_selector("option[value='18400']", text: region.name)
      )
    end

    context 'when a region is in the session' do
      it 'should set the selected value to that region' do
        session[:region] = region.slug
        expect(results).to(
          have_selector("option[value='18400'][selected='selected']")
        )
      end
    end
  end

end
