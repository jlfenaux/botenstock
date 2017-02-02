class Platform < ApplicationRecord
  belongs_to :bot
  belongs_to :provider
  validates :url, url: true, allow_blank: true
end