class Admin::DynamicContentsController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class DynamicContentParams

    # Internal: Build params for creating/updating a DynamicContent.
    #
    # Examples
    #
    #   DynamicContentParams.build(dynamic_content: { subject: 'biography' })
    #   # => { 'subject' => 'biography' }
    def self.build(params)
      params.require(:dynamic_content).permit!
    end
  end

  def index
    @dynamic_contents = DynamicContent.all.group_by(&:region)
  end

  def edit
    @dynamic_content = DynamicContent.find(params[:id])
  end

  def update
    @dynamic_content = DynamicContent.find(params[:id])
    if @dynamic_content.update_attributes(DynamicContentParams.build(params))
      redirect_to admin_dynamic_contents_path, notice: 'Content successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the content.'
      render :edit
    end
  end

  def new
    @dynamic_content = DynamicContent.new
    @dynamic_content.region_id = params[:region_id] unless params[:region_id].blank?
  end

  def create
    @dynamic_content = DynamicContent.new(DynamicContentParams.build(params))
    if @dynamic_content.save
      redirect_to admin_dynamic_contents_path, notice: 'Content successfully created!'
    else
      flash.now[:error] = 'Oops! There was a problem creating the content.'
      render :new
    end
  end

  def destroy
    if DynamicContent.find(params[:id]).destroy
      flash[:notice] = 'Content successfully deleted!'
    else
      flash[:error] = 'Oops! There was a problem deleting the content.'
    end

    redirect_to admin_dynamic_contents_path
  end

end
