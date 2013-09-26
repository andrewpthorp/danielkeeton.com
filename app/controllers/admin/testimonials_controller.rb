class Admin::TestimonialsController < Admin::BaseController

  def index
    @testimonials = Testimonial.all
  end

  def edit
    @testimonial = Testimonial.find(params[:id])
  end

  def update; end

  def new
    @testimonial = Testimonial.new
  end

  def create; end
  def destroy; end

end
