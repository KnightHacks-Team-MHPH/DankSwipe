class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.integer :user_id
      t.string :meme_url
      t.integer :right_swipes
      t.integer :left_swipes
      
      t.timestamps null: false
    end
  end
end
