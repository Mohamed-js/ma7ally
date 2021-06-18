class AddDoneToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :done, :boolean, :default => false
  end
end
