class Meme < ActiveRecord::Base
  belongs_to :user
  has_many :swipes
  has_many :investments
  
  def sell
    # find the user that invested the most
    highest_investment = self.investments.order("amount ASC").first
    investment_owner = highest_investment.user
    # assign the meme to the new owner
    self.owner_id = investment_owner.id
    self.save!
    
    # disperse investments once again
    self.investments.each do |investment|
      investment_user = investment.user
      # give the user back its currency
      investment_user.currency += investment.amount.to_i
      investment_user.save!
      # remove the investment
      investment.destroy!
    end
    
    # give the user the currency for each collected right swipe minus the left swipes
    right_swipes = self.swipes.where(direction: :right, collected: false).count
    left_swipes = self.swipes.where(direction: :left, collected: false).count
    self.user.currency += right_swipes - left_swipes
    
    # we have used them, set them to collected so they wont be recounted in future sales
    self.swipes.each do |swipe|
      swipe.collected = true
      swipe.save!
    end
  end
end
