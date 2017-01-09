class Bot < ApplicationRecord
  validates_uniqueness_of :permalink
  validates_presence_of :permalink
  before_validation :create_permalink

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
