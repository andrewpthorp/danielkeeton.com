class Admin::PostsController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class PostParams

    # Internal: Build params for creating/updating a Post.
    #
    # Examples
    #
    #   PostParams.build(post: { title: 'A Title' })
    #   # => { 'title' => 'A Title' }
    def self.build(params)
      params.require(:post).permit!
    end
  end

  def index
    @published = Post.published
    @drafts = Post.drafted
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(PostParams.build(params))
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
    @post = Post.new(PostParams.build(params))

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
