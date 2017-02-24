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

require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
