class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :quantity
      t.integer :item_id
      t.integer :user_id
      t.integer :trader_id
      t.string :status

      t.timestamps
    end
  end
end
