class Bot < ApplicationRecord
  has_many :platforms
  accepts_nested_attributes_for :platforms
  validates_uniqueness_of :permalink
  validates_presence_of :permalink
  validates :amazon_echo_url, url: {allow_blank: true}
  validates :android_url, url: {allow_blank: true}
  validates :discord_url, url: {allow_blank: true}
  validates :email_url, url: {allow_blank: true}
  validates :imessage_url, url: {allow_blank: true}
  validates :ios_url, url: {allow_blank: true}
  validates :kik_url, url: {allow_blank: true}
  validates :messenger_url, url: {allow_blank: true}
  validates :skype_url, url: {allow_blank: true}
  validates :slack_url, url: {allow_blank: true}
  validates :sms_url, url: {allow_blank: true}
  validates :telegram_url, url: {allow_blank: true}
  validates :twitter_url, url: {allow_blank: true}
  validates :web_url, url: {allow_blank: true}
  before_validation :create_permalink

  has_attached_file :logo,
    styles: { medium: "300x300#", thumb: "100x100#" },
    default_url: "/images/:style/botenstock.png"

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  include PgSearch
  pg_search_scope :search_for, against: %i(name description_en tagline_en description_fr tagline_fr)

  CATEGORIES = [
    'Actualités',
    'Business',
    'Cinéma',
    'Communication',
    'Cuisine/Gastronomie',
    'Divertissement',
    'Don/Caritatif',
    'Education',
    'Finance',
    'Fun',
    'Jeux',
    'Marque',
    'Paiements',
    'Personnel',
    'Productivité',
    'Réseaux sociaux',
    'Santé',
    'Shopping',
    'Sport',
    'Sécurité',
    'Utilitaires',
    'Voyage'
  ]
  LANGUAGES = ['Anglais', 'Français']

  def platform_url(platform)
    id = Provider.where(code: platform).first
    self.platforms.select{|p| p.provider_id == id}.first.url
    # send("#{platform.downcase}_url")
  end

  def tagline
    send("tagline_#{I18n.locale}")
  end

  def description
    send("description_#{I18n.locale}")
  end

  private

  def create_permalink
    self.permalink = name.parameterize.to_s.gsub("_", "-")
    # self.platforms= []
    # PLATFORMS.each do |platform|
    #    self.platforms << platform unless platform_url(platform).blank?
    # end
    self.languages = self.languages.delete_if{|l| l.blank?}
    self.categories = self.categories.delete_if{|l| l.blank?}
  end


end
