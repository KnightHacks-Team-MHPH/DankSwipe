class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :memes
  has_many :swipes
  has_many :investments
  
  def currency_invested
    return 0
  end
  
  def currency_available
    return 0
  end
end
