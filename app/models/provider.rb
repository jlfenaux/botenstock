# == Schema Information
#
# Table name: providers
#
#  id                :integer          not null, primary key
#  name              :string
#  description_en    :text
#  description_fr    :text
#  website_url       :string
#  directory_url     :string
#  code              :string
#  visible           :boolean
#  icon_file_name    :string
#  icon_content_type :string
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#

class Provider < ApplicationRecord
  has_many :platforms
  has_attached_file :icon,
    styles: { medium: "300x300", small: "100x100", thumb: "35x35"}
    # default_url: "/images/:style/botenstock.png"

  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/

  scope :visible, -> {where(visible: true).where('icon_content_type is not null')}
  scope :featured, -> {where(featured: true)}
  scope :sorted, -> {order(:order)}

  def description
    send("description_#{I18n.locale}")
  end
end
