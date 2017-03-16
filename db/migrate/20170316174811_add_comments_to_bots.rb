class AddCommentsToBots < ActiveRecord::Migration[5.0]
  def change
    add_column :bots, :comments, :text
  end
end
