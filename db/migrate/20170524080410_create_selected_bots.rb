class CreateSelectedBots < ActiveRecord::Migration[5.0]
  def change
    create_table :selected_bots do |t|
      t.references :bot, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
