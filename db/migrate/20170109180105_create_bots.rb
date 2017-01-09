class CreateBots < ActiveRecord::Migration[5.0]
  def change
    create_table :bots do |t|
      t.string :name
      t.text :description
      t.string :website
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
