Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :home, only: [:index, :show]

  get '/users', to: "users#index"

  scope "u" do
    get ':username', to: 'users#show', as: :user
    # resources :users do
    get '/:username/listings/', to: 'users#user_listings', as: "user_listings"
    # end
  end
  
  # T2A2-10 As a user I want to create a listing
  resources :listings, except: :user_listings

  # scope shallow_path: "u" do
  #   resources :user do
  #     resources :listings, param: :title, shallow: true, except: :index
  #   end
  # end
  
  # resources :listings, except: :show
  
  # get '/u/:username/:title', to: "listings#show", as: "listing"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
