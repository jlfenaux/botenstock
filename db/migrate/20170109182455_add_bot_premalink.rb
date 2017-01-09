class AddBotPremalink < ActiveRecord::Migration[5.0]
  def change
    add_column :bots, :permalink, :string
    add_index :bots, :permalink
  end
end
