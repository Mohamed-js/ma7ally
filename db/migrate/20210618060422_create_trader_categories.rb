class CreateTraderCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :trader_categories do |t|
      t.integer :trader_id
      t.integer :category_id

      t.timestamps
    end
  end
end
