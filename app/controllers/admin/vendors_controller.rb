class Admin::VendorsController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class VendorParams

    # Internal: Build params for creating/updating a Vendor.
    #
    # Examples
    #
    #   VendorParams.build(vendor: { subject: 'biography' })
    #   # => { 'subject' => 'biography' }
    def self.build(params)
      params.require(:vendor).permit!
    end
  end

  def index
    @vendors = Vendor.all
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update_attributes(VendorParams.build(params))
      redirect_to admin_vendors_path, notice: 'Vendor successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the vendor.'
      render :edit
    end
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(VendorParams.build(params))
    if @vendor.save
      redirect_to admin_vendors_path, notice: 'Vendor successfully created!'
    else
      flash.now[:error] = 'Oops! There was a problem creating the vendor.'
      render :new
    end
  end

  def destroy
    if Vendor.find(params[:id]).destroy
      flash[:notice] = 'Vendor successfully deleted!'
    else
      flash[:error] = 'Oops! There was a problem deleting the vendor.'
    end

    redirect_to admin_vendors_path
  end

end
