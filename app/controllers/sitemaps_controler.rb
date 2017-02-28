class SitemapsController < ApplicationController
  def sitemap
    redirect_to "https://s3.amazonaws.com/botenstock/sitemaps/sitemap.xml.gz"
  end
end