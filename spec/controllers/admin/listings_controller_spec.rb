require 'spec_helper'

describe Admin::ListingsController do
  before do
    @listing = FactoryGirl.create(:listing)
    sign_in_admin
  end

  describe Admin::ListingsController::ListingParams do
    let (:hash) { { listing: { title: 'A Title' } } }
    let (:params) { ActionController::Parameters.new(hash) }
    let (:blank_params) { ActionController::Parameters.new({}) }

    it 'scrubs the parameters' do
      listing_params = Admin::ListingsController::ListingParams.build(params)
      expect(listing_params).to eq({'title' => 'A Title'})
    end

    it 'requires a listing' do
      expect { Admin::ListingsController::ListingParams.build(blank_params) }.to(
        raise_error(ActionController::ParameterMissing, /listing/)
      )
    end
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

  describe 'PUT update' do
    it 'should assign @listing' do
      put :update, { id: @listing.id, listing: { title: 'A Title' } }
      expect(assigns(:listing)).to eq(@listing)
    end

    context 'when updating succeeds' do
      it 'should set the flash appropriately' do
        put :update, { id: @listing.id, listing: { title: 'A Title' } }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_listings_path' do
        put :update, { id: @listing.id, listing: { title: 'A Title' } }
        expect(response).to redirect_to(admin_listings_path)
      end
    end

    context 'when updating fails' do
      it 'should set the flash appropriately' do
        put :update, { id: @listing.id, listing: { title: '' } }
        expect(flash[:error]).to match(/problem updating/)
      end

      it 'should render the edit template' do
        put :update, { id: @listing.id, listing: { title: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET new' do
    it 'should assign @listing' do
      get :new
      expect(assigns(:listing)).to be_a_new(Listing)
    end
  end

  describe 'POST create' do
    it 'should assign @listing' do
      post :create, listing: { title: 'A Title' }
      expect(assigns(:listing)).to be_a(Listing)
    end

    context 'when creating succeeds' do
      before do
        Listing.any_instance.stub(:save).and_return(true)
      end

      it 'should set the flash appropriately' do
        post :create, listing: { title: 'A Title' }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_listings_path' do
        post :create, listing: { title: 'A Title' }
        expect(response).to redirect_to(admin_listings_path)
      end
    end

    context 'when creating fails' do
      it 'should set the flash appropriately' do
        post :create, listing: { title: 'A Title' }
        expect(flash[:error]).to match(/problem creating/)
      end

      it 'should render the new template' do
        post :create, listing: { title: 'A Title' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'should redirect to the admin_listings_path' do
      delete :destroy, id: @listing.id
      expect(response).to redirect_to(admin_listings_path)
    end

    context 'when destroy succeeds' do
      it 'should set the flash appropriately' do
        delete :destroy, id: @listing.id
        expect(flash[:notice]).to match(/success/)
      end
    end

    context 'when destroy fails' do
      it 'should set the flash appropriately' do
        Listing.stub(:find).and_return(@listing)
        @listing.stub(:destroy).and_return(false)
        delete :destroy, id: @listing.id
        expect(flash[:error]).to match(/problem deleting/)
      end
    end
  end

end
