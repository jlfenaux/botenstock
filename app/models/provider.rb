class Provider < ApplicationRecord
  has_many :platforms
  has_attached_file :icon,
    styles: { medium: "300x300", small: "100x100", thumb: "35x35"}
    # default_url: "/images/:style/botenstock.png"

  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/

  scope :visible, -> {where(visible: true).where('icon_content_type is not null')}

  def description
    send("description_#{I18n.locale}")
  end
end