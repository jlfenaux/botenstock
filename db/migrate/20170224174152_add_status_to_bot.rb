class AddStatusToBot < ActiveRecord::Migration[5.0]
  def change
    add_column :bots, :status, :string, default: 'pending'
  end
end
