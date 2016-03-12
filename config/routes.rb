Rails.application.routes.draw do
  # devise_for :users
  root 'welcomes#index'
  get 'top' => 'topics#index'
  post 'top' => 'topics#create', as: :new
  post 'res' => 'response#res'
  post 'edit' => 'topics#edit'
  get '/auth/twitter/callback' => 'sessions#twitter'
  get '/auth/facebook/callback' => 'sessions#facebook'
  get '/logout' => 'sessions#destroy', as: :logout


end
