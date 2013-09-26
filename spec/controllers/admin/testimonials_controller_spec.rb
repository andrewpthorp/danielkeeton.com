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

  describe 'GET new' do
    it 'should assign @testimonial' do
      get :new
      expect(assigns(:testimonial)).to be_a_new(Testimonial)
    end
  end

end
