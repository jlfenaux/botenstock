class BlogController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin
  def index
    @posts = Post.published.language(I18n.locale).order('published_at desc').paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @post = Post.where(permalink: params[:permalink]).first

  end
end
