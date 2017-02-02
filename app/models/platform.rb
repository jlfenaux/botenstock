class Platform < ApplicationRecord
  belongs_to :bot
  belongs_to :provider
  validates :url, url: true, allow_blank: true

  scope :visible, -> {joins(:provider).where('providers.visible = ?', true).where('url is not null')}
end