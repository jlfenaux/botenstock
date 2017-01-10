class Bot < ApplicationRecord
  validates_uniqueness_of :permalink
  validates_presence_of :permalink
  before_validation :create_permalink

  has_attached_file :logo,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/:style/botenstock.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  PLATFORMS = ['Amazon_Echo', 'Android', 'Discord', 'Email', 'iMessage', 'iOS', 'Kik', 'Messenger', 'Skype', 'Slack', 'SMS', 'Telegram', 'Twitter', 'Web']
  CATEGORIES = [
    'Actualités',
    'Business',
    'Education',
    'Finance',
    'Jeux',
    'Shopping',
    'Sport',
    'Utilitaires',
    'Voyage'
  ]
  def to_param
    permalink
  end


  private

  def create_permalink
    self.permalink = name.parameterize.to_s.gsub("_", "-")
  end


end
