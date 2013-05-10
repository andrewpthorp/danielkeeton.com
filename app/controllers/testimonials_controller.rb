class TestimonialsController < ApplicationController

  def index
    @section = 'testimonials'
    @testimonials = Testimonial.all
  end

end
