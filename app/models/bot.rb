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
#  amazon_echo_url   :string
#  android_url       :string
#  discord_url       :string
#  email_url         :string
#  imessage_url      :string
#  ios_url           :string
#  kik_url           :string
#  messenger_url     :string
#  skype_url         :string
#  slack_url         :string
#  sms_url           :string
#  telegram_url      :string
#  twitter_url       :string
#  web_url           :string
#  tagline_en        :string
#  description_en    :text
#  tested_on         :date
#  test_en           :text
#  test_fr           :text
#

class Bot < ApplicationRecord
  has_many :platforms
  accepts_nested_attributes_for :platforms , allow_destroy: true, reject_if: proc { |attributes| attributes['url'].blank? || attributes['provider_id'].nil?}
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
  scope :ok, -> { where(status: 'ok')}

  STATUSES = ['ok', 'pending', 'to_be_checked']

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

  def description
    send("description_#{I18n.locale}")
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
    self.languages = self.languages.delete_if{|l| l.blank?}
    self.categories = self.categories.delete_if{|l| l.blank?}
  end


end
