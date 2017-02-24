class AddOrderToProvider < ActiveRecord::Migration[5.0]
  def change
      add_column :providers, :order, :integer
      add_column :providers, :featured, :boolean
  end
end
