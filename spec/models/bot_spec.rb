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
#  tagline_en        :string
#  description_en    :text
#  tested_on         :date
#  test_en           :text
#  test_fr           :text
#  status            :string           default("pending")
#

require 'rails_helper'

RSpec.describe Bot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
