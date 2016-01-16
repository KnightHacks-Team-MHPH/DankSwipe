Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  
  resources :memes
  
  get '/swipe' => "memes#swipe_index"
  post '/swipe/:id/left' => "memes#swipe_left", as: :left_swipe
  post '/swipe/:id/right' => "memes#swipe_right", as: :right_swipe
end
