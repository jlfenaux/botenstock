class SitemapsController < ApplicationController
  def sitemap
    redirect_to "https://s3-eu-west-1.amazonaws.com/botenstock/sitemaps/sitemap.xml.gz"
  end
end