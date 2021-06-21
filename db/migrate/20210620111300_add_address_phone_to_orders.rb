class AddAddressPhoneToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address, :text
    add_column :orders, :phone, :string
    add_column :orders, :phone2, :string
  end
end
