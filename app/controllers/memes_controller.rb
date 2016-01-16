class MemesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @memes = current_user.memes
  end
  
  def show
    
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def destroy
    
  end
end
