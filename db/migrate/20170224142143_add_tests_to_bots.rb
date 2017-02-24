class AddTestsToBots < ActiveRecord::Migration[5.0]
  def change
    add_column :bots, :tested_on, :date
    add_column :bots, :test_en, :text
    add_column :bots, :test_fr, :text
  end
end
