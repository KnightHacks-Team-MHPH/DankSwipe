class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :memes
  has_many :acquired_memes, class_name: 'Meme', foreign_key: 'owner_id'
  has_many :swipes
  has_many :investments
  
  def currency_invested
    total = 0
    self.investments.each do |investment|
      total += investment.amount
    end
    return total
  end
  
  def currency_available
    return self.currency
  end
end
