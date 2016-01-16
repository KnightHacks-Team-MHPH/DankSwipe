class AddCollectedAttributeToSwipes < ActiveRecord::Migration
  def change
    add_column :swipes, :collected, :boolean, default: false
  end
end
