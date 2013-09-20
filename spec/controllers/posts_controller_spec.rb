require 'spec_helper'

describe PostsController do
  before do
    @post = FactoryGirl.create(:published_post)
    @testimonial = FactoryGirl.create(:testimonial)
  end

  describe 'GET index' do
    it 'should assign @section' do
      get :index
      expect(assigns(:section)).to eq('posts')
    end

    it 'should assign @posts' do
      get :index
      expect(assigns(:posts)).to eq([@post])
    end

    it 'should assign @testimonials' do
      get :index
      expect(assigns(:testimonials)).to eq([@testimonial])
    end
  end

  describe 'GET show' do
    it 'should assign @section' do
      get :show, id: @post.id
      expect(assigns(:section)).to eq('posts')
    end

    it 'should assign @post' do
      get :show, id: @post.id
      expect(assigns(:post)).to eq(@post)
    end
  end

end
