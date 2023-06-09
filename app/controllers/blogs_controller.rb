class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
    @user=User.find(current_user.id)
    @myblog=Blog.where(user: @user)
  end

  # GET /blogs/1 or /blogs/1.json
  def show

  end
  def book
    @blog = Blog.find(params[:id])
    @user = User.find(params[:userid])
    @bookmark = Bookmark.new(user: @user, blog: @blog)

    if @bookmark.save
      redirect_to home_index_path, notice: 'Blog bookmarked successfully.'
    else
      redirect_to home_index_path, alert: 'Failed to bookmark the blog.'
    end
  end


  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user=current_user
    @blog.name=@blog.user.email
    @blog.likes=0
    @blog.dislikes=0
    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to home_index_path, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:name, :designation, :content, :likes, :dislikes,pictures:[])
    end
end
