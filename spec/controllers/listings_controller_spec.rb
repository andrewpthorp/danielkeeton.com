require 'spec_helper'

describe ListingsController do
  before do
    @listing = FactoryGirl.create(:featured_listing)
  end

  describe 'GET index' do
    it 'should assign @section' do
      get :index, status: 'for_sale'
      expect(assigns(:section)).to eq('listings')
    end

    it 'should assign @status' do
      get :index, status: 'for_rent'
      expect(assigns(:status)).to eq('for_rent')
    end

    context 'when passing in a status' do
      context 'and the status is inavlid' do
        it 'should raise an HTTP 404' do
          get :index, status: 'foobar'
          expect(response.code).to eq('404')
        end
      end

      context 'and the status is for_sale' do
        it 'should assign @listings to for_sale listings' do
          @listing.update_attributes(status: 'for_sale')
          get :index, status: 'for_sale'
          expect(assigns(:listings)).to eq([@listing])
        end
      end

      context 'and the status is for_rent' do
        it 'should assign @listings to for_rent listings' do
          @listing.update_attributes(status: 'for_rent')
          get :index, status: 'for_rent'
          expect(assigns(:listings)).to eq([@listing])
        end
      end

      context 'and the status is under_contract' do
        it 'should assign @listings to under_contract listings' do
          @listing.update_attributes(status: 'under_contract')
          get :index, status: 'under_contract'
          expect(assigns(:listings)).to eq([@listing])
        end
      end

      context 'and the status is sold' do
        it 'should assign @listings to sold listings' do
          @listing.update_attributes(status: 'sold')
          get :index, status: 'sold'
          expect(assigns(:listings)).to eq([@listing])
        end
      end
    end
  end

  describe 'GET index' do
    it 'should assign @section' do
      get :show, id: @listing.id
      expect(assigns(:section)).to eq('listings')
    end

    it 'should assign @listing' do
      get :show, id: @listing.id
      expect(assigns(:listing)).to eq(@listing)
    end
  end
end
