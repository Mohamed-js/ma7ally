class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.integer :quantity
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
