class MemesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @memes = current_user.memes
  end
  
  def new
    @meme = current_user.memes.new
  end
  
  def create
    @meme = current_user.memes.create!(allowed_params)
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
  end
  
  def swipe_left
    @meme = Meme.find(params[:id])
    @swipe = @meme.swipes.create!(user_id: current_user.id, direction: :left)
    @unseen_meme = get_unseen_meme(cur_user)
    
    respond_to do |format|
      format.js
    end
  end
  
  def swipe_right
    @meme = Meme.find(params[:id])
    @swipe = @meme.swipes.create!(user_id: current_user.id, direction: :right)
    @unseen_meme = get_unseen_meme(cur_user)
    
    respond_to do |format|
      format.js
    end
  end
  
private
  def allowed_params
    params.require(:meme).permit(:meme_url)
  end
  
  # get multiple memes
  def get_unseen_memes(cur_user)
    other_memes = Meme.where().not(user_id: cur_user)
    unseen_memes = []
    other_memes.each do |meme|
      if !(meme.swipes.where(user_id: cur_user.id).count > 0)
        unseen_memes << meme
      end
    end
    return unseen_memes
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
