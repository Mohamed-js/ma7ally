class ChangeTraderPasswordToDigest < ActiveRecord::Migration[6.1]
  def change
    rename_column :traders, :password, :password_digest
  end
end