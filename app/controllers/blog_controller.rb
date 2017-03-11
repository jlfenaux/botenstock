class BlogController < ApplicationController
  def index
    @posts = Post.published.language(I18n.locale).order('published_at desc').paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @post = Post.where(permalink: params[:permalink]).first
    render plain: '404 Not found', status: 404  if @post.nil?
  end
end
