class Admin::PagesController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class PageParams

    # Internal: Build params for creating/updating a Page.
    #
    # Examples
    #
    #   PageParams.build(post: { title: 'A Title' })
    #   # => { 'title' => 'A Title' }
    def self.build(params)
      params.require(:page).permit!
    end
  end

  def index
    @pages = Page.all
  end

  def edit
    @post = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(PageParams.build(params))
      redirect_to admin_pages_path, notice: 'Page successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the page.'
      render :edit
    end
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(PageParams.build(params))

    if @page.save
      redirect_to admin_pages_path, notice: 'Page successfully created!'
    else
      flash.now[:error] = 'Oops! There was a problem creating the page.'
      render :new
    end
  end

  def destroy
    if Page.find(params[:id]).destroy
      flash[:notice] = 'Page successfully deleted!'
    else
      flash[:error] = 'Oops! There was a problem deleting the page.'
    end

    redirect_to admin_pages_path
  end

end
