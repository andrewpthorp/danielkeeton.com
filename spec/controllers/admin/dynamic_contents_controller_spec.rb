require 'spec_helper'

describe Admin::DynamicContentsController do
  before do
    @dynamic_content = FactoryGirl.create(:dynamic_content)
    sign_in_admin
  end

  describe Admin::DynamicContentsController::DynamicContentParams do
    let (:hash) { { dynamic_content: { subject: 'biography' } } }
    let (:params) { ActionController::Parameters.new(hash) }
    let (:blank_params) { ActionController::Parameters.new({}) }

    it 'scrubs the parameters' do
      dynamic_content_params = Admin::DynamicContentsController::DynamicContentParams.build(params)
      expect(dynamic_content_params).to eq({'subject' => 'biography'})
    end

    it 'requires a dynamic_content' do
      expect { Admin::DynamicContentsController::DynamicContentParams.build(blank_params) }.to(
        raise_error(ActionController::ParameterMissing, /dynamic_content/)
      )
    end
  end

  describe 'GET index' do
    it 'should assign @dynamic_contents grouped by region' do
      regioned = FactoryGirl.create(:dynamic_content_with_region)
      get :index
      expect(assigns(:dynamic_contents)).to eq({
        nil => [@dynamic_content],
        regioned.region => [regioned]
      })
    end
  end

  describe 'GET edit' do
    it 'should assign @dynamic_content' do
      get :edit, id: @dynamic_content.id
      expect(assigns(:dynamic_content)).to eq(@dynamic_content)
    end
  end

  describe 'PUT update' do
    it 'should assign @dynamic_content' do
      put :update, { id: @dynamic_content.id, dynamic_content: { subject: 'biography' } }
      expect(assigns(:dynamic_content)).to eq(@dynamic_content)
    end

    context 'when updating succeeds' do
      it 'should set the flash appropriately' do
        put :update, { id: @dynamic_content.id, dynamic_content: { subject: 'biography' } }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_dynamic_contents_path' do
        put :update, { id: @dynamic_content.id, dynamic_content: { subject: 'biography' } }
        expect(response).to redirect_to(admin_dynamic_contents_path)
      end
    end

    context 'when updating fails' do
      it 'should set the flash appropriately' do
        put :update, { id: @dynamic_content.id, dynamic_content: { subject: 'invalid' } }
        expect(flash[:error]).to match(/problem updating/)
      end

      it 'should render the edit template' do
        put :update, { id: @dynamic_content.id, dynamic_content: { subject: 'invalid' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET new' do
    it 'should assign @dynamic_content' do
      get :new
      expect(assigns(:dynamic_content)).to be_a_new(DynamicContent)
    end

    context 'when passing :region_id as a parameter' do
      it 'should assign .region_id on @dynamic_content' do
        region = FactoryGirl.create(:region)
        get :new, region_id: region.id
        expect(assigns(:dynamic_content).region).to eq(region)
      end
    end
  end

  describe 'POST create' do
    it 'should assign @dynamic_content' do
      post :create, dynamic_content: { subject: 'biography' }
      expect(assigns(:dynamic_content)).to be_a(DynamicContent)
    end

    context 'when creating succeeds' do
      before do
        DynamicContent.any_instance.stub(:save).and_return(true)
      end

      it 'should set the flash appropriately' do
        post :create, dynamic_content: { subject: 'biography' }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_dynamic_contents_path' do
        post :create, dynamic_content: { subject: 'biography' }
        expect(response).to redirect_to(admin_dynamic_contents_path)
      end
    end

    context 'when creating fails' do
      it 'should set the flash appropriately' do
        post :create, dynamic_content: { subject: 'biography' }
        expect(flash[:error]).to match(/problem creating/)
      end

      it 'should render the new template' do
        post :create, dynamic_content: { subject: 'biography' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'should redirect to the admin_dynamic_contents_path' do
      delete :destroy, id: @dynamic_content.id
      expect(response).to redirect_to(admin_dynamic_contents_path)
    end

    context 'when destroy succeeds' do
      it 'should set the flash appropriately' do
        delete :destroy, id: @dynamic_content.id
        expect(flash[:notice]).to match(/success/)
      end
    end

    context 'when destroy fails' do
      it 'should set the flash appropriately' do
        DynamicContent.stub(:find).and_return(@dynamic_content)
        @dynamic_content.stub(:destroy).and_return(false)
        delete :destroy, id: @dynamic_content.id
        expect(flash[:error]).to match(/problem deleting/)
      end
    end
  end

end
