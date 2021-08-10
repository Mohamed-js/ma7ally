class RemoveItemIdFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :item_id
    remove_column :orders, :quantity
  end
end
