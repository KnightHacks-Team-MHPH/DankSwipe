class MemesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @memes = current_user.memes
  end
  
  def new
    @meme = current_user.memes.new
  end
  
  def create
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
    # create the swipe as an investment
    @swipe = @meme.swipes.create!(user_id: current_user.id, direction: :invest)
    # log the investment
    @investment = @meme.investments.create!(user_id: current_user.id, amount: investment_params[:amount])
    # prep for next meme
    @unseen_meme = get_unseen_meme(current_user)
    if !@unseen_meme.nil?
      @meme_investment = @unseen_meme.investments.new
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
