require 'spec_helper'

describe TestimonialsController do
  before do
    @testimonial = FactoryGirl.create(:testimonial)
  end

  describe 'GET index' do
    it 'should assign @section' do
      get :index
      expect(assigns(:section)).to eq('testimonials')
    end

    it 'should assign @testimonials' do
      get :index
      expect(assigns(:testimonials)).to eq([@testimonial])
    end
  end

end
