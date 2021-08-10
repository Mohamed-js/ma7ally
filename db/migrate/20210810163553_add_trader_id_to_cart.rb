class AddTraderIdToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :trader_id, :integer
  end
end
