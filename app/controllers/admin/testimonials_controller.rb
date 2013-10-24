class Admin::TestimonialsController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class TestimonialParams

    # Internal: Build params for creating/updating a Testimonial.
    #
    # Examples
    #
    #   TestimonialParams.build(testimonial: { title: 'A Title' })
    #   # => { 'title' => 'A Title' }
    def self.build(params)
      params.require(:testimonial).permit!
    end
  end

  def index
    @testimonials = Testimonial.all
  end

  def edit
    @testimonial = Testimonial.find(params[:id])
  end

  def update
    @testimonial = Testimonial.find(params[:id])
    if @testimonial.update_attributes(TestimonialParams.build(params))
      redirect_to admin_testimonials_path, notice: 'Testimonial successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the testimonial.'
      render :edit
    end
  end

  def new
    @testimonial = Testimonial.new
  end

  def create
    @testimonial = Testimonial.new(TestimonialParams.build(params))

    if @testimonial.save
      redirect_to admin_testimonials_path, notice: 'Testimonial successfully created!'
    else
      flash.now[:error] = 'Oops! There was a problem creating the testimonial.'
      render :new
    end
  end

  def destroy
    if Testimonial.find(params[:id]).destroy
      flash[:notice] = 'Testimonial successfully deleted!'
    else
      flash[:error] = 'Oops! There was a problem deleting the testimonial.'
    end

    redirect_to admin_testimonials_path
  end

end
