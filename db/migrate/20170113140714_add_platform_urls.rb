class AddPlatformUrls < ActiveRecord::Migration[5.0]
  def change
    add_column :bots, :amazon_echo_url, :string
    add_column :bots, :android_url, :string
    add_column :bots, :discord_url, :string
    add_column :bots, :email_url, :string
    add_column :bots, :imessage_url, :string
    add_column :bots, :ios_url, :string
    add_column :bots, :kik_url, :string
    add_column :bots, :messenger_url, :string
    add_column :bots, :skype_url, :string
    add_column :bots, :slack_url, :string
    add_column :bots, :sms_url, :string
    add_column :bots, :telegram_url, :string
    add_column :bots, :twitter_url, :string
    add_column :bots, :web_url, :string
  end
end
