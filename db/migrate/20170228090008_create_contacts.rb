class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :object
      t.text :question
      t.string :language
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
