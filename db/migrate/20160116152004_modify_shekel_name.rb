class ModifyShekelName < ActiveRecord::Migration
  def change
    remove_column :users, :shekels
    add_column :users, :currency, :integer, default: 1000
  end
end
