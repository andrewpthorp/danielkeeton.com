require 'spec_helper'

describe Admin::PostsController do
  before do
    @post = FactoryGirl.create(:post)
    sign_in_admin
  end

  describe Admin::PostsController::PostParams do
    let (:hash) { { post: { title: 'A Title' } } }
    let (:params) { ActionController::Parameters.new(hash) }
    let (:blank_params) { ActionController::Parameters.new({}) }

    it 'scrubs the parameters' do
      post_params = Admin::PostsController::PostParams.build(params)
      expect(post_params).to eq({'title' => 'A Title'})
    end

    it 'requires a post' do
      expect { Admin::PostsController::PostParams.build(blank_params) }.to(
        raise_error(ActionController::ParameterMissing, /post/)
      )
    end
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

  describe 'PUT update' do
    it 'should assign @post' do
      put :update, { id: @post.id, post: { title: 'A Title' } }
      expect(assigns(:post)).to eq(@post)
    end

    context 'when updating succeeds' do
      it 'should set the flash appropriately' do
        put :update, { id: @post.id, post: { title: 'A Title' } }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_posts_path' do
        put :update, { id: @post.id, post: { title: 'A Title' } }
        expect(response).to redirect_to(admin_posts_path)
      end
    end

    context 'when updating fails' do
      it 'should set the flash appropriately' do
        put :update, { id: @post.id, post: { title: '' } }
        expect(flash[:error]).to match(/problem updating/)
      end

      it 'should render the edit template' do
        put :update, { id: @post.id, post: { title: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET new' do
    it 'should assign @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST create' do
    it 'should assign @post' do
      post :create, post: { title: 'A Title' }
      expect(assigns(:post)).to be_a(Post)
    end

    context 'when creating succeeds' do
      before do
        Post.any_instance.stub(:save).and_return(true)
      end

      it 'should set the flash appropriately' do
        post :create, post: { title: 'A Title' }
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to the admin_posts_path' do
        post :create, post: { title: 'A Title' }
        expect(response).to redirect_to(admin_posts_path)
      end
    end

    context 'when creating fails' do
      it 'should set the flash appropriately' do
        post :create, post: { title: 'A Title' }
        expect(flash[:error]).to match(/problem creating/)
      end

      it 'should render the new template' do
        post :create, post: { title: 'A Title' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'should redirect to the admin_posts_path' do
      delete :destroy, id: @post.id
      expect(response).to redirect_to(admin_posts_path)
    end

    context 'when destroy succeeds' do
      it 'should set the flash appropriately' do
        delete :destroy, id: @post.id
        expect(flash[:notice]).to match(/success/)
      end
    end

    context 'when destroy fails' do
      it 'should set the flash appropriately' do
        Post.stub(:find).and_return(@post)
        @post.stub(:destroy).and_return(false)
        delete :destroy, id: @post.id
        expect(flash[:error]).to match(/problem deleting/)
      end
    end
  end

end
