require 'spec_helper'

describe Admin::ListingsController do
  before do
    @listing = FactoryGirl.create(:listing)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should assign @listings' do
      get :index
      expect(assigns(:listings)).to eq([@listing])
    end
  end

  describe 'GET edit' do
    it 'should assign @listing' do
      get :edit, id: @listing.id
      expect(assigns(:listing)).to eq(@listing)
    end
  end

  describe 'GET new' do
    it 'should assign @listing' do
      get :new
      expect(assigns(:listing)).to be_a_new(Listing)
    end
  end

end
