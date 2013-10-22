class Admin::DynamicContentsController < Admin::BaseController

  def index
    @dynamic_contents = DynamicContent.all
  end

  def edit
    @dynamic_content = DynamicContent.find(params[:id])
  end

  def update
    @dynamic_content = DynamicContent.find(params[:id])
    if @dynamic_content.update_attributes(params[:dynamic_content])
      redirect_to admin_dynamic_contents_path, notice: 'Content successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the content.'
      render :edit
    end
  end

  def new
    @dynamic_content = DynamicContent.new
  end

  def create
    @dynamic_content = DynamicContent.new(params[:dynamic_content])
    if @dynamic_content.save
      redirect_to admin_dynamic_contents_path, notice: 'Content successfully created!'
    else
      flash.now[:error] = 'Oops! There was a problem creating the content.'
      render :new
    end
  end

end
