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
    it 'should happen on every request' do
      controller.should_receive(:set_current_region)
      get :index
    end

    context 'when passing a region in as a parameter' do
      it 'should store the region in the session' do
        get :index, region: 'richmond'
        expect(session[:region]).to eq('richmond')
      end

      context 'and the region is all' do
        it 'should clear the region from the session' do
          session[:region] = 'richmond'
          get :index, region: 'all'
          expect(session[:region]).to be_nil
        end
      end
    end

    context 'when not passing a region in as a parameter' do
      it 'should not clear the region from the session' do
        session[:region] = 'richmond'
        get :index
        expect(session[:region]).to eq('richmond')
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
