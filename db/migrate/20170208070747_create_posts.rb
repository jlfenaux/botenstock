class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :permalink
      t.string :language
      t.datetime :published_at

      t.timestamps
    end
  end
end