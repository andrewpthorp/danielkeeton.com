class Admin::ListingsController < Admin::BaseController

  def index
    @listings = Listing.all
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(params[:listing])
      redirect_to admin_listings_path, notice: 'Listing successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the listing.'
      render :edit
    end
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(params[:listing])

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
