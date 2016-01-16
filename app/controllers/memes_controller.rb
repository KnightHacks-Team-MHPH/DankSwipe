class MemesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @memes = current_user.memes
  end
  
  def show
    
  end
  
  def new
    @meme = current_user.memes.new
  end
  
  def create
    @meme = current_user.memes.create!(allowed_params)
    redirect_to memes_path
  end
  
  def destroy
    
  end
  
private
  def allowed_params
    params.require(:meme).permit(:meme_url)
  end
end
