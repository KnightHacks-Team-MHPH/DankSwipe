class AddOwnershipForOwnershipTransfer < ActiveRecord::Migration
  def change
    add_column :memes, :owner_id, :integer
  end
end
