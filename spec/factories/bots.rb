# == Schema Information
#
# Table name: bots
#
#  id                :integer          not null, primary key
#  name              :string
#  description_fr    :text
#  website           :string
#  twitter           :string
#  facebook          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  categories        :string           is an Array
#  permalink         :string
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  tagline_fr        :string
#  product_hunt_url  :string
#  venture_beat_url  :string
#  languages         :string           is an Array
#  amazon_echo_url   :string
#  android_url       :string
#  discord_url       :string
#  email_url         :string
#  imessage_url      :string
#  ios_url           :string
#  kik_url           :string
#  messenger_url     :string
#  skype_url         :string
#  slack_url         :string
#  sms_url           :string
#  telegram_url      :string
#  twitter_url       :string
#  web_url           :string
#  tagline_en        :string
#  description_en    :text
#

FactoryGirl.define do
  factory :bot do
    name "MyString"
    description "MyText"
    website "MyString"
    twitter "MyString"
    facebook "MyString"
  end
end
