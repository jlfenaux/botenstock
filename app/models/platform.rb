# == Schema Information
#
# Table name: platforms
#
#  id          :integer          not null, primary key
#  bot_id      :integer
#  provider_id :integer
#  url         :string
#

class Platform < ApplicationRecord
  belongs_to :bot
  belongs_to :provider
  validates :url, url: true, allow_blank: true

  scope :visible, -> {joins(:provider).where('providers.visible = ?', true).order('providers.order asc').where("url is not null and url != ''")}
end
