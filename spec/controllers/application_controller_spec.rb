require 'spec_helper'

describe ApplicationController do

  controller do
    def index
      if params[:error]
        render_404
      else
        head :success
      end
    end
  end

  describe 'set_current_section' do
    it 'should happen on every request' do
      controller.should_receive(:set_current_section)
      get :index
    end

    it 'should set @section to params[:controller]' do
      get :index, controller: 'anonymous'
      expect(assigns(:section)).to eq('anonymous')
    end
  end

  describe 'set_current_region' do
    before do
      FactoryGirl.create(:region, slug: 'goochland', linkable: true)
      FactoryGirl.create(:region, slug: 'sussex', linkable: false)
    end

    it 'should happen on every request' do
      controller.should_receive(:set_current_region)
      get :index
    end

    context 'when the subdomain is not www' do
      context 'and it is a linkable region slug' do
        it 'should set the region to the subdomain' do
          @request.host = 'goochland.danielkeeton.com'
          get :index
          expect(session[:region]).to eq('goochland')
        end
      end

      context 'and it is not a valid region slug' do
        it 'should delete the region from the session' do
          @request.host = 'foobar.danielkeeton.com'
          get :index
          expect(session[:region]).to be_nil
        end
      end

      context 'and it is not a linkable region slug' do
        it 'should delete the region from the session' do
          @request.host = 'sussex.danielkeeton.com'
          get :index
          expect(session[:region]).to be_nil
        end
      end
    end

    context 'when the subdomain is www' do
      it 'should delete the region from the session' do
        @request.host = 'www.danielkeeton.com'
        get :index
        expect(session[:region]).to be_nil
      end
    end

    context 'when there is no subdomain' do
      it 'should delete the region from the session' do
        @request.host = 'danielkeeton.com'
        get :index
        expect(session[:region]).to be_nil
      end
    end
  end

  describe 'render_404' do
    it 'should render the correct file' do
      get :index, error: true
      expect(response).to render_template(file: "#{Rails.root}/public/404.html")
    end

    it 'should have the correct status' do
      get :index, error: true
      expect(response.response_code).to eq(404)
    end
  end

end
