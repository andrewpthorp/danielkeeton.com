class Admin::ListingsController < Admin::BaseController

  def index
    @listings = Listing.all
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update; end

  def new
    @listing = Listing.new
  end

  def create; end
  def destroy; end

end
