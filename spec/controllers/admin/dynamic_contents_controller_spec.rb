require 'spec_helper'

describe Admin::DynamicContentsController do
  before do
    @dynamic_content = FactoryGirl.create(:dynamic_content)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should assign @dynamic_contents' do
      get :index
      expect(assigns(:dynamic_contents)).to eq([@dynamic_content])
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
      put :update, { id: @dynamic_content.id, dynamic_content: {} }
      expect(assigns(:dynamic_content)).to eq(@dynamic_content)
    end

    context 'when updating succeeds' do
      it 'should set the flash appropriately' do
        put :update, { id: @dynamic_content.id, dynamic_content: {} }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_dynamic_contents_path' do
        put :update, { id: @dynamic_content.id, dynamic_content: {} }
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
  end

  describe 'POST create' do
    it 'should assign @dynamic_content' do
      post :create, dynamic_content: {}
      expect(assigns(:dynamic_content)).to be_a(DynamicContent)
    end

    context 'when creating succeeds' do
      before do
        DynamicContent.any_instance.stub(:save).and_return(true)
      end

      it 'should set the flash appropriately' do
        post :create, dynamic_content: {}
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_dynamic_contents_path' do
        post :create, dynamic_content: {}
        expect(response).to redirect_to(admin_dynamic_contents_path)
      end
    end

    context 'when creating fails' do
      it 'should set the flash appropriately' do
        post :create, dynamic_content: {}
        expect(flash[:error]).to match(/problem creating/)
      end

      it 'should render the new template' do
        post :create, dynamic_content: {}
        expect(response).to render_template(:new)
      end
    end
  end

end
