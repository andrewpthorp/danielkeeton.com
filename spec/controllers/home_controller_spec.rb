require 'spec_helper'

describe HomeController do
  let (:mailer) { double('Mailer') }

  before do
    Mailer.stub_chain(:home_worth_email, :deliver)
    Mailer.stub_chain(:contact_email, :deliver)
  end

  describe 'GET index' do
    it 'should assign @section' do
      get :index
      expect(assigns(:section)).to eq('home')
    end

    it 'should assign @featured_listing' do
      l = FactoryGirl.create(:featured_listing)
      get :index
      expect(assigns(:featured_listing)).to eq(l)
    end

    it 'should assign @testimonial' do
      t = FactoryGirl.create(:testimonial)
      get :index
      expect(assigns(:testimonial)).to eq(t)
    end

    it 'should assign @post' do
      p = FactoryGirl.create(:published_post)
      get :index
      expect(assigns(:post)).to eq(p)
    end
  end

  describe 'POST homeworth' do
    it 'should send an email' do
      Mailer.stub(:home_worth_email).and_return(mailer)
      mailer.should_receive(:deliver)
      post :homeworth, {}
    end

    it 'should set the flash' do
      post :homeworth, {}
      expect(flash[:success]).to match(/received your request/)
    end

    it 'should redirect to the root' do
      post :homeworth, {}
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST contact' do
    it 'should send an email' do
      Mailer.stub(:contact_email).and_return(mailer)
      mailer.should_receive(:deliver)
      post :contact, {}
    end

    it 'should set the flash' do
      post :contact, {}
      expect(flash[:success]).to match(/received your email/)
    end

    it 'should redirect to the root' do
      post :contact, {}
      expect(response).to redirect_to(root_path)
    end
  end

end
