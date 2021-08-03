class AddTotalToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total, :integer, :default => 0
    add_column :orders, :currency, :string, :default => "$"
  end
end
