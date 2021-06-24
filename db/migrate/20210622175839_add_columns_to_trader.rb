class AddColumnsToTrader < ActiveRecord::Migration[6.1]
  def change
    add_column :traders, :first_visit, :boolean, :default => true
    add_column :traders, :plan, :string, :default => "trial"
    add_column :traders, :items_count, :integer, :default => 0
    add_column :traders, :items_limit, :integer, :default => 20
  end
end
