class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.integer :meme_id
      t.integer :user_id
      t.integer :amount
      t.timestamps null: false
    end
    
    add_column :users, :shekels, :integer, default: 0
    add_column :memes, :sold, :boolean
  end
end
