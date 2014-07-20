class InquiriesController < ApplicationController

  # Internal: A testable class for use with strong_parameters.
  class InquiryParams

    # Internal: Build params for creating an Inquiry.
    #
    # Examples
    #
    #   IqniryParams.build(inquiry: { type: 'homeworth' })
    #   # => { 'type' => 'homeworth' }
    def self.build(params)
      params.require(:inquiry).permit!
    end
  end

  def create
    inquiry = Inquiry.new(InquiryParams.build(params))

    if inquiry.save
      flash[:success] = 'Success! I have received your message. Thanks!'
    else
      flash[:error] = 'Whoops! There was an error sending your message. All fields are required.'
    end

    redirect_to root_path
  end

end
