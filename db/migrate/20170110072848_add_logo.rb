class AddLogo < ActiveRecord::Migration
  def up
    add_attachment :bots, :logo
  end

  def down
    remove_attachment :bots, :logo
  end
end
