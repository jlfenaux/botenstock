# == Schema Information
#
# Table name: photos
#
#  id                :integer          not null, primary key
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Photo < ApplicationRecord
  has_one :post
  has_attached_file :file, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/photos/:style/missing.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
