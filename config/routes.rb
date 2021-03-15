Rails.application.routes.draw do
  resources :listings
  devise_for :users
  root to: 'home#index'
  resources :home
  # resources :users, :only => [:show]
  get '/users', to: "users#index"
  get '/u/:username', to: "users#show", as: "profile"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
