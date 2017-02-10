class AddSummaryToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :summary,  :text
    add_reference :posts, :photo, foreign_key: true
  end
end
