Rails.application.routes.draw do
  # root route for the marketplace home page
  root 'home#index'

  # routes for session management (login and logout)
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout

  # routes for user registration and password resets
  get 'signup', to: 'registrations#new', as: :new_registration
  resources :registrations, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # route for the user's profile --> creates profile_path
  resource :profile, only: [:show], controller: 'users'

  # user routes
  resources :users, only: [:show] do
    # nested routes for user-specific actions
    resources :messages, only: [:create]
    resources :listings, only: [:index, :destroy]
  end

  # route for messaging a seller from their profile
  post 'message_seller/:user_id', to: 'conversations#create_for_user', as: :message_seller_user
  get '/verify/:token', to: 'verification#verify', as: 'verify_account'
  # routes for products, reviews, and listings
  resources :products do
    # actions related to products
    member do
      post :add_to_cart
      post :message_seller
      post :write_review
      post :add_to_favorites
      post :promote
      delete :unpromote
    end
    resources :listings
    resources :reviews, only: [:new, :create, :destroy]
    get 'search', on: :collection
  end

  # listings and reviews routes
  resources :listings
  resources :reviews, only: [:new, :create]

  # routes for orders, cart, and related actions
  resources :orders, only: [:new, :create, :show] do
    resources :feedback, only: [:new, :create]
    resource :tracking, only: [:show]
  end

  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy] do
    member do
      patch :increase
      patch :decrease
    end
  end

  # routes for notifications, favorites, feedback, and categories
  resources :notifications, only: [:show]
  resources :favorites, only: [:index, :create, :destroy]
  resources :feedback, only: [:new, :create]
  resources :categories, only: [:index, :show]

  # routes for conversations and messages

  resources :conversations, only: [:index, :show, :destroy] do
    resources :messages, only: [:create]
  end
  get '/messages', to: 'messages#index'

  # additional routes
  get 'search', to: 'search#index', as: 'search'
  get 'trackings/:order_id', to: 'trackings#show', as: 'trackings_show'
  get 'categories/index'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end


