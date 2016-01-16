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
  
private
  def allowed_params
    params.require(:meme).permit(:meme_url)
  end
end
