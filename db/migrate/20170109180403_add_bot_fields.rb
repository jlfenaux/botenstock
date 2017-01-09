class AddBotFields < ActiveRecord::Migration[5.0]
  def change


    add_column :bots, :categories, :string , array: true
    add_index :bots, :categories, using: 'gin'
    add_column :bots, :platforms, :string , array: true
    add_index :bots, :platforms, using: 'gin'
    add_index :bots, "to_tsvector('french', name || ' ' || description)", using: :gin, name: 'bot_search_idx'

  end
end
