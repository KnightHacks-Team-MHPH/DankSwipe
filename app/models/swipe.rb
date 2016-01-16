class Swipe < ActiveRecord::Base
  enum direction: [:left, :right]
  belongs_to :user
  belongs_to :meme
end
