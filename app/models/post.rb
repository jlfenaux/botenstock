class Post < ApplicationRecord
  before_validation :create_permalink
  validates_uniqueness_of :permalink
  validates_presence_of :permalink
  scope :published, -> {where('published_at >= now()')}
  scope :language, -> (lang) {where(language: lang)}

  def published
    return 'Draft' if published_at.nil?
    I18n.l published_at, format: :long
  end

  def html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(body).html_safe
  end
   private

  def create_permalink
    self.title = title.strip
    self.permalink = title.parameterize.to_s.gsub("_", "-")
  end
end
