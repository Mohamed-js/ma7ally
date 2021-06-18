class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :item_id
      t.string :user_id
      t.string :trader_id
      t.integer :quantity

      t.timestamps
    end
  end
end
