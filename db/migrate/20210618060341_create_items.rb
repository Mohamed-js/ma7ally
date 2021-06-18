class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :size
      t.string :unit
      t.integer :quantity
      t.integer :category_id
      t.integer :trader_id
      t.text :image_data

      t.timestamps
    end
  end
end
