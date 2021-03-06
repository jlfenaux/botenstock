  # == Schema Information
#
# Table name: bots
#
#  id                :integer          not null, primary key
#  name              :string
#  description_fr    :text
#  website           :string
#  twitter           :string
#  facebook          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  categories        :string           is an Array
#  permalink         :string
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  tagline_fr        :string
#  product_hunt_url  :string
#  venture_beat_url  :string
#  languages         :string           is an Array
#  tagline_en        :string
#  description_en    :text
#  tested_on         :date
#  test_en           :text
#  test_fr           :text
#  status            :string           default("pending")
#

class Bot < ApplicationRecord
  has_many :platforms
  accepts_nested_attributes_for :platforms , allow_destroy: true, reject_if: proc { |attributes| attributes['url'].blank? || attributes['provider_id'].nil?}
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :permalink, presence: true, uniqueness: true
  before_validation :create_permalink
  before_save :check_status_change

  has_attached_file :logo,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/:style/botenstock.png"

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  include PgSearch
  pg_search_scope :search_for, against: %i(name description_en tagline_en description_fr tagline_fr)
  scope :ok, -> { where(status: 'ok')}



  STATUSES = ['ok', 'pending', 'discarded', 'incomplete']

  CATEGORIES = [
    'Actualités',
    'Business',
    'Cinéma',
    'Communication',
    'Cuisine/Gastronomie',
    'Dev',
    'Divertissement',
    'Don/Caritatif',
    'Education',
    'Femme',
    'Finance',
    'Fun',
    'Jeux',
    "Marketing",
    'Marque',
    'Paiements',
    'Personnel',
    'Productivité',
    'Réseaux sociaux',
    'Ressources Humaines',
    'Santé',
    'Shopping',
    'Sport',
    'Sécurité',
    'Utilitaires',
    'Voyage'
  ]

  LANGUAGES = ['en', 'fr']

  def platform_url(platform)
    id = Provider.where(code: platform).first
    self.platforms.select{|p| p.provider_id == id}.first.url
  end
  def visible_platforms
    platforms.visible
  end

  def tagline
    send("tagline_#{I18n.locale}")
  end

  def related_bots
    bots = Bot.ok
    categories.each do |cat|
      bots = bots.where(" ? = ANY(categories)", cat)
    end
    bots = bots.where("id != ?", id)
    bots.limit(5)
  end

  def description
    content = send("description_#{I18n.locale}")
    return '' if content.blank?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(content).html_safe
  end

  def self.migrate_languages
    Bot.all.each do |bot|
      if bot.languages && bot.languages.any?
        languages = bot.languages
        new_languages = []
        new_languages << 'fr' if languages.include?('Français')
        new_languages << 'en' if languages.include?('Anglais')
        bot.languages = new_languages
        bot.save
      end
    end
  end

  private

  def create_permalink
    self.name = name.strip
    self.permalink = name.parameterize.to_s.gsub("_", "-")
    # self.platforms= []
    # PLATFORMS.each do |platform|
    #    self.platforms << platform unless platform_url(platform).blank?
    # end
    self.languages = self.languages.delete_if{|l| l.blank?} if self.languages
    self.categories = self.categories.delete_if{|l| l.blank?} if self.categories
  end

  def check_status_change
    status_changed = self.changes.fetch("status"){nil}
    if status_changed && status_changed[1] == 'ok'
      self.created_at = Time.now
    end
  end

end
