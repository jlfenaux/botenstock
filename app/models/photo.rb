class Photo < ApplicationRecord
  has_attached_file :file, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/photos/:style/missing.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
