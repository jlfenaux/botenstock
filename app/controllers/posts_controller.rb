class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  layout "admin"
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @posts = @posts.order('published_at desc').paginate(:page => params[:page], :per_page => 20)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    redirect_to blog_article_path(permalink: @post.permalink)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def preview
    @post = Post.new(body: params[:preview_text])
    render text: @post.html
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Le post a été créé.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Le post a été mis à jour.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Le post a été supprimé.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published_at, :language, :photo_id, :summary)
    end
end
