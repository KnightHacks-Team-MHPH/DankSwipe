class Swipe < ActiveRecord::Base
  enum direction: [:left, :right, :invest]
  belongs_to :user
  belongs_to :meme
end
