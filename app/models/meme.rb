class Meme < ActiveRecord::Base
  belongs_to :user
  has_many :swipes
end
