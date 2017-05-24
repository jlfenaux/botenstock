class SelectedBot < ApplicationRecord
  belongs_to :bot
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :greater_than_start
  def self.draw(item_numbers = 1)
    SelectedBot.where('now() between start_date and end_date').order('random()').limit(item_numbers).map(&:bot)
  end

  private

  def greater_than_start
    errors.add(:end_date, I18n.t("activerecord.errors.models.selected_bot.attributes.end_date.wrong")) unless self.end_date > self.start_date
  end
end
