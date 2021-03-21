Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :home, only: [:index, :show]

  get '/users', to: "users#index"

  scope "u" do
    get ':username', to: 'users#show', as: :user
    get '/:username/listings', to: 'users#user_listings', as: "user_listings"

    ## I can use something like this to redirec to a modal until
    ## I implement something like micromodal.js. It's a bit smelly
    ## But it will get the job done without JS.
    # => (https://medium.com/@JasonCodes/simple-modals-in-ruby-on-rails-with-micromodal-f91165269ae2)
    ## Or use the first half of this tutorial (until the modifying Devise with JS stuff,
    ## Which I can try once everything is done and dusted.)
    ## get '/:username/t', to: 'users#test_route', as: "test"
  end
  
  # T2A2-10 As a user I want to create a listing
  resources :listings, except: :user_listings
  
  # T2A2-18 AS a user I want to make an offer on other people's listings
  # => From  https://gorails.com/episodes/nested-comment-threads-in-rails-part-1
  # nests trades in listings, allows for listings/trades controller, which will
  # be used to pass @listing to trades#new.
  resources :listings do
    resources :trades, only: [:create], module: :listings
  end

  resources :trades, only: [:show, :edit, :update]
 
  # scope shallow_path: "u" do
  #   resources :user do
  #     resources :listings, param: :title, shallow: true, except: :index
  #   end
  # end

end
