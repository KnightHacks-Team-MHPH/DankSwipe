class Meme < ActiveRecord::Base
  belongs_to :user
  has_many :swipes
  has_many :investments
  
  def sell
    # find the user that invested the most
    highest_investment = @meme.investments.order("amount ASC").first
    investment_owner = highest_investment.first.user
    # assign the meme to the new owner
    @meme.owner_id = investment_owner.id
    @meme.save!
    
    # disperse the other investments since they lost
    @meme.investments.where.not(investment_id: highest_investment.id).each do |investment|
      investment_user = investment.user
      # give the user back its currency
      investment_user.currency += investment.amount.to_i
      investment_user.save!
      # remove the investment
      investment.destroy!
    end
    
    # give the user the currency for each collected right swipe minus the left swipes
    right_swipes = @meme.swipes.where(direction: :right, collected: false).count
    left_swipes = @meme.swipes.where(direction: :left, collected: false).count
    @meme.user.currency += right_swipes - left_swipes
    
    # we have used them, set them to collected so they wont be recounted in future sales
    @meme.swipes.each do |swipe|
      swipe.collected = true
      swipe.save!
    end
  end
end
