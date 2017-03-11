# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  object     :integer
#  question   :text
#  language   :string
#  done       :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ApplicationRecord

  validates_presence_of :name, :question, :email, :object
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  scope :pending, -> {
    where(done: false)
  }
  def self.objects
    [ [I18n.t('contact.objects')[1], 1],
      [I18n.t('contact.objects')[2], 2]
    ]
  end
end
