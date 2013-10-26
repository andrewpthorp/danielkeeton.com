class Admin::ListingsController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class ListingParams

    # Internal: Build params for creating/updating a Listing.
    #
    # Examples
    #
    #   ListingParams.build(listing: { title: 'A Title' })
    #   # => { 'title' => 'A Title' }
    def self.build(params)
      params.require(:listing).permit!
    end
  end

  def index
    @listings = Listing.all.group_by(&:status)
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(ListingParams.build(params))
      redirect_to admin_listings_path, notice: 'Listing successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the listing.'
      render :edit
    end
  end

  def new
    @listing = Listing.new
    @listing.status = params[:status] unless params[:status].blank?
  end

  def create
    @listing = Listing.new(ListingParams.build(params))

    if @listing.save
      redirect_to admin_listings_path, notice: 'Listing successfully created!'
    else
      flash.now[:error] = 'Oops! There was a problem creating the listing.'
      render :new
    end
  end

  def destroy
    if Listing.find(params[:id]).destroy
      flash[:notice] = 'Listing successfully deleted!'
    else
      flash[:error] = 'Oops! There was a problem deleting the listing.'
    end

    redirect_to admin_listings_path
  end

end
