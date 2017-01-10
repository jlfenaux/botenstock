class AddNewBotFields < ActiveRecord::Migration[5.0]
  def change
    add_column :bots, :tagline, :string
    add_column :bots, :product_hunt_url, :string
    add_column :bots, :venture_beat_url, :string
    add_column :bots, :languages, :string, array: true

    # remove_index(:bit, :name => 'index_name')

  end
end
