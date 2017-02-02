class AddPlatformsTables < ActiveRecord::Migration[5.0]
  def up
    create_table :providers do |t|
      t.string :name
      t.text :description_en
      t.text :description_fr
      t.string :website_url
      t.string :directory_url
      t.string :code
      t.boolean :visible
    end

    create_table :platforms do |t|
      t.integer :bot_id
      t.integer :provider_id
      t.string :url
    end
    add_attachment :providers, :icon
    remove_column :bots, :platforms

    Provider.create(name: 'Alexa',     code: 'amazon_echo', visible: true)
    Provider.create(name: 'Android',   code: 'android',     visible: true)
    Provider.create(name: 'Discord',   code: 'discord',     visible: true)
    Provider.create(name: 'Email',     code: 'email',       visible: true)
    Provider.create(name: 'iMessage',  code: 'imessage',    visible: true)
    Provider.create(name: 'iOS',       code: 'ios',         visible: true)
    Provider.create(name: 'Kik',       code: 'kik',         visible: true)
    Provider.create(name: 'Messenger', code: 'messenger',   visible: true)
    Provider.create(name: 'Skype',     code: 'skype',       visible: true)
    Provider.create(name: 'Slack',     code: 'slack',       visible: true)
    Provider.create(name: 'SMS',       code: 'sms',         visible: true)
    Provider.create(name: 'Telegram',  code: 'telegram',    visible: true)
    Provider.create(name: 'Twitter',   code: 'twitter',     visible: true)
    Provider.create(name: 'Web',       code: 'web',         visible: true)

    Bot.all.each do |bot|
      Provider.all.each do |provider|
        url = bot.send("#{provider.code}_url")
        bot.platforms << Platform.new(provider_id: provider.id, url: url) unless url.blank?
      end
    end
  end
  def down
    drop_table :providers
    drop_table :platforms
    add_column :bots, :platforms, :string , array: true
  end
end
