class Admin::PostsController < Admin::BaseController

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to admin_posts_path, notice: 'Post successfully updated!'
    else
      flash.now[:error] = 'Oops! There was a problem updating the post.'
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to admin_posts_path, notice: 'Post successfully created!'
    else
      flash.now[:error] = 'Oops! There was a problem creating the post.'
      render :new
    end
  end

  def destroy
    if Post.find(params[:id]).destroy
      flash[:notice] = 'Post successfully deleted!'
    else
      flash[:error] = 'Oops! There was a problem deleting the post.'
    end

    redirect_to admin_posts_path
  end

end
