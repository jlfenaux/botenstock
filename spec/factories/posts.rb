# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string
#  body         :text
#  permalink    :string
#  language     :string
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  summary      :text
#  photo_id     :integer
#

FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    published_at "MyString"
  end
end
