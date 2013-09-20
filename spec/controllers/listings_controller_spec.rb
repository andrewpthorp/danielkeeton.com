require 'spec_helper'

describe ListingsController do
  before do
    @listing = FactoryGirl.create(:featured_listing)
  end

  describe 'GET index' do
    it 'should assign @section' do
      get :index
      expect(assigns(:section)).to eq('listings')
    end

    it 'should assign @featured' do
      get :index
      expect(assigns(:featured)).to eq(@listing)
    end

    it 'should assign @for_sale' do
      @listing.update_attributes(status: 'for_sale')
      get :index
      expect(assigns(:for_sale)).to eq([@listing])
    end

    it 'should assign @for_rent' do
      @listing.update_attributes(status: 'for_rent')
      get :index
      expect(assigns(:for_rent)).to eq([@listing])
    end

    it 'should assign @under_contract' do
      @listing.update_attributes(status: 'under_contract')
      get :index
      expect(assigns(:under_contract)).to eq([@listing])
    end

    it 'should assign @sold' do
      @listing.update_attributes(status: 'sold')
      get :index
      expect(assigns(:sold)).to eq([@listing])
    end
  end

end
