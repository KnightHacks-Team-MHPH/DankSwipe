class CreateSwipes < ActiveRecord::Migration
  def change
    create_table :swipes do |t|
      t.integer :direction
      t.integer :user_id
      t.integer :meme_id

      t.timestamps null: false
    end
    
    #we dont need this, its trackable through swipes
    remove_column :memes, :left_swipes
    remove_column :memes, :right_swipes
  end
end
