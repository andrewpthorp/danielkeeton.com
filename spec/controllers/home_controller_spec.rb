require 'spec_helper'

describe HomeController do
  describe 'GET index' do
    it 'should assign @section' do
      get :index
      expect(assigns(:section)).to eq('home')
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

    it 'should assign @biography' do
      c = FactoryGirl.create(:dynamic_content, subject: 'biography')
      get :index
      expect(assigns(:biography)).to eq(c)
    end
  end
end
