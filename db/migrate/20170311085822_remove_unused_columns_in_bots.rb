class RemoveUnusedColumnsInBots < ActiveRecord::Migration[5.0]
  def change
    remove_column :bots, :amazon_echo_url, :string
    remove_column :bots, :android_url, :string
    remove_column :bots, :discord_url, :string
    remove_column :bots, :email_url, :string
    remove_column :bots, :imessage_url, :string
    remove_column :bots, :ios_url, :string
    remove_column :bots, :kik_url, :string
    remove_column :bots, :messenger_url, :string
    remove_column :bots, :skype_url, :string
    remove_column :bots, :slack_url, :string
    remove_column :bots, :sms_url, :string
    remove_column :bots, :telegram_url, :string
    remove_column :bots, :twitter_url, :string
    remove_column :bots, :web_url, :string
  end
end
