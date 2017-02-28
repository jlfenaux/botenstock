require 'rubygems'
require 'sitemap_generator'

sitemaps_path = "sitemaps/"
sitemaps_path += "dev/" if Rails.env == "development"
SitemapGenerator::Sitemap.default_host = "http://botsforchatting.com"
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/botenstock/"
SitemapGenerator::Sitemap.sitemaps_path = sitemaps_path
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'aws',
                                                                    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                                    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                    fog_region: 'eu-west-1',
                                                                    fog_directory: 'botenstock')


SitemapGenerator::Sitemap.create do
[:en, :fr].each do |lang|
    p lang
    add send("root_#{lang}_path"), changefreq: 'daily'
    Bot::CATEGORIES.each do |cat|
      Provider.visible.each do |platform|
        add Directory.new(platform: platform, category: cat ,language: :all, locale: lang).path
      end
      add Directory.new(platform: :all, category: cat ,language: :all, locale: lang).path
    end
    Provider.visible.each do |platform|
      add Directory.new(platform: platform, category: :all ,language: :all, locale: lang).path
    end
    add Directory.new(platform: :all, category: :all ,language: :all, locale: lang).path
    Bot.ok.each  do |bot|
      add send("bot_page_#{lang}_path", permalink: bot.permalink)
    end
  end
end