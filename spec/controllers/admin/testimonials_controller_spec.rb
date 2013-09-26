require 'spec_helper'

describe Admin::TestimonialsController do
  before do
    @testimonial = FactoryGirl.create(:testimonial)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should assign @testimonials' do
      get :index
      expect(assigns(:testimonials)).to eq([@testimonial])
    end
  end

  describe 'GET edit' do
    it 'should assign @testimonial' do
      get :edit, id: @testimonial.id
      expect(assigns(:testimonial)).to eq(@testimonial)
    end
  end

  describe 'PUT update' do
    it 'should assign @testimonial' do
      put :update, { id: @testimonial.id, testimonial: {} }
      expect(assigns(:testimonial)).to eq(@testimonial)
    end

    context 'when updating succeeds' do
      it 'should set the flash appropriately' do
        put :update, { id: @testimonial.id, testimonial: {} }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_testimonials_path' do
        put :update, { id: @testimonial.id, testimonial: {} }
        expect(response).to redirect_to(admin_testimonials_path)
      end
    end

    context 'when updating fails' do
      it 'should set the flash appropriately' do
        put :update, { id: @testimonial.id, testimonial: { name: '' } }
        expect(flash[:error]).to match(/problem updating/)
      end

      it 'should render the edit template' do
        put :update, { id: @testimonial.id, testimonial: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET new' do
    it 'should assign @testimonial' do
      get :new
      expect(assigns(:testimonial)).to be_a_new(Testimonial)
    end
  end

  describe 'POST create' do
    it 'should assign @testimonial' do
      post :create, testimonial: {}
      expect(assigns(:testimonial)).to be_a(Testimonial)
    end

    context 'when creating succeeds' do
      before do
        Testimonial.any_instance.stub(:save).and_return(true)
      end

      it 'should set the flash appropriately' do
        post :create, testimonial: {}
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_testimonials_path' do
        post :create, testimonial: {}
        expect(response).to redirect_to(admin_testimonials_path)
      end
    end

    context 'when creating fails' do
      it 'should set the flash appropriately' do
        post :create, testimonial: {}
        expect(flash[:error]).to match(/problem creating/)
      end

      it 'should render the new template' do
        post :create, testimonial: {}
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'should redirect to the admin_testimonials_path' do
      delete :destroy, id: @testimonial.id
      expect(response).to redirect_to(admin_testimonials_path)
    end

    context 'when destroy succeeds' do
      it 'should set the flash appropriately' do
        delete :destroy, id: @testimonial.id
        expect(flash[:notice]).to match(/success/)
      end
    end

    context 'when destroy fails' do
      it 'should set the flash appropriately' do
        Testimonial.stub(:find).and_return(@testimonial)
        @testimonial.stub(:destroy).and_return(false)
        delete :destroy, id: @testimonial.id
        expect(flash[:error]).to match(/problem deleting/)
      end
    end
  end

end
