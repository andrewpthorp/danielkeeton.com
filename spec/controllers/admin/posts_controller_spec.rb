require 'spec_helper'

describe Admin::PostsController do
  before do
    @post = FactoryGirl.create(:post)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should assign @posts' do
      get :index
      expect(assigns(:posts)).to eq([@post])
    end
  end

  describe 'GET edit' do
    it 'should assign @post' do
      get :edit, id: @post.id
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe 'GET new' do
    it 'should assign @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

end
