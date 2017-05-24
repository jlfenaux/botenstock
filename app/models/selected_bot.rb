class SelectedBot < ApplicationRecord
  belongs_to :bot

  def self.draw(item_numbers = 1)
    SelectedBot.where('now() between start_date and end_date').order('random()').limit(item_numbers).map(&:bot)
  end
end
