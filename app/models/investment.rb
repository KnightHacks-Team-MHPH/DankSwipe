class Investment < ActiveRecord::Base
  belongs_to :meme
  belongs_to :user
end
