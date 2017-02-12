class Post < ApplicationRecord
  before_validation :create_permalink
  validates_uniqueness_of :permalink
  validates_presence_of :permalink
  validates_presence_of :photo_id
  validates_presence_of :title
  validates_presence_of :language
  validates_presence_of :summary
  belongs_to :photo
  scope :published, -> {where('published_at <= now()')}
  scope :language, -> (lang) {where(language: lang)}

  def published
    return 'Draft' if published_at.nil?
    I18n.l published_at, format: :long
  end

  def html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    content = body
    content.gsub!(/§photo\((\d*)\)/) do
      photo = Photo.find_by_id($1.to_i)
      %(<img class='img-responsive' src="#{photo.file(:original)}">) if photo.present?
    end
    content.gsub!(/§bot_name\((\d*)\)/) do
      bot = Bot.find_by_id($1.to_i)
      bot.name if bot.present?
    end
    content.gsub!(/§bot_logo\((\d*)\)/) do
      bot = Bot.find_by_id($1.to_i)
      %(<img src="#{bot.logo(:medium)}">) if bot.present?
    end
    content.gsub!(/§bot_link\((\d*)\)/) do
      bot = Bot.find_by_id($1.to_i)
      %(<a href='#{Rails.application.routes.url_helpers.bot_page_path(permalink: bot.permalink)}' target='_new' >#{bot.name}</a>) if bot.present?
    end
    markdown.render(content).html_safe
  end
   private

  def create_permalink
    self.title = title.strip
    self.permalink = title.parameterize.to_s.gsub("_", "-")
  end
end
