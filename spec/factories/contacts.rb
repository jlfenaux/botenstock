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

FactoryGirl.define do
  factory :contact do
    name "MyString"
    email "MyString"
    object 1
    question "MyText"
    language "MyString"
    done false
  end
end
