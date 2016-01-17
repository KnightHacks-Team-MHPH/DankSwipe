class MemesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    pre_memes = current_user.memes
    @memes = []
    pre_memes.each do |meme|
      if (meme.user_id == meme.owner_id) || ((meme.user_id == current_user.id) && meme.owner_id.nil?)
        @memes << meme
      end
    end
  end
  
  def acquired_memes
    @memes = current_user.acquired_memes
  end
  
  def new
    @meme = current_user.memes.new
  end
  
  def create
    # note that we dont create it with an owner_id since we dont want this to
    # show up in acquired memes until after a sale
    @meme = current_user.memes.create!(meme_params)
    flash[:success] = "You have successfully created a meme!"
    redirect_to memes_path
  end
  
  def destroy
    @meme = current_user.memes.find(params[:id])
    @meme.destroy!
    flash[:success] = "You have successfully removed your meme!"
    redirect_to memes_path
  end
  
  def sell
    @meme = current_user.memes.find(params[:id])
    success = @meme.sell
    if success
      flash[:success] = "You have successfully sold your meme!"
    else
      flash[:error] = "Unfortunately, you can't sell your meme right now."
    end
    redirect_to memes_path
  end
  
  def swipe_index
    @unseen_meme = get_unseen_meme(current_user)
    if !@unseen_meme.nil?
      @meme_investment = @unseen_meme.investments.new
    end
  end
  
  def swipe_left
    @meme = Meme.find(params[:id])
    @swipe = @meme.swipes.create!(user_id: current_user.id, direction: :left)
    @unseen_meme = get_unseen_meme(current_user)
    if !@unseen_meme.nil?
      @meme_investment = @unseen_meme.investments.new
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  def swipe_right
    @meme = Meme.find(params[:id])
    @swipe = @meme.swipes.create!(user_id: current_user.id, direction: :right)
    @unseen_meme = get_unseen_meme(current_user)
    if !@unseen_meme.nil?
      @meme_investment = @unseen_meme.investments.new
    end
    respond_to do |format|
      format.js
    end
  end
  
  def invest
    @meme = Meme.find(params[:id])
    @good_investment = false
    # log the investment
    if current_user.can_invest?(investment_params[:amount])
      # create the swipe as an investment
      @swipe = @meme.swipes.create!(user_id: current_user.id, direction: :invest)
      
      @investment = @meme.investments.create!(user_id: current_user.id, amount: investment_params[:amount])
      
      # reduce the amount of currency the user has by how much they invested.
      current_user.currency -= investment_params[:amount].to_i
      current_user.save!
      
      # prep for next meme
      @unseen_meme = get_unseen_meme(current_user)
      if !@unseen_meme.nil?
        @meme_investment = @unseen_meme.investments.new
      end
      
      @good_investment = true
    else
      flash[:error] = "You dont have that many danks to invest (wo)man. Come on..."
    end
    respond_to do |format|
      format.js
    end
  end
  
private
  def meme_params
    params.require(:meme).permit(:meme_url)
  end
  def investment_params
    params.require(:investment).permit(:amount)
  end
  
  # only get one meme
  def get_unseen_meme(cur_user)
    other_memes = Meme.where().not(user_id: cur_user)
    unseen_meme = nil
    other_memes.each do |meme|
      if !(meme.swipes.where(user_id: cur_user.id).count > 0)
        unseen_meme = meme
        break
      end
    end
    return unseen_meme
  end
end
