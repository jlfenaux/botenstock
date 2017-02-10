class BlogController < ApplicationController
  def index
    @posts = Post.published.order('published_at desc').paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @post = Post.where(permalink: params[:permalink]).first

  end
end