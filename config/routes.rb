Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  
  resources :memes
  get '/acquired_memes' => "memes#acquired_memes", as: :acquired_memes
  post '/sell/:id' => "memes#sell", as: :sell_meme
  
  get '/swipe' => "memes#swipe_index"
  post '/swipe/:id/left' => "memes#swipe_left", as: :left_swipe
  post '/swipe/:id/right' => "memes#swipe_right", as: :right_swipe
  post '/invest/:id' => "memes#invest", as: :investment
end
