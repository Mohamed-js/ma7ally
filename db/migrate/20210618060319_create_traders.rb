class CreateTraders < ActiveRecord::Migration[6.1]
  def change
    create_table :traders do |t|
      t.string :storename
      t.string :tradername
      t.string :email
      t.string :password
      t.text :image_data

      t.timestamps
    end
  end
end
