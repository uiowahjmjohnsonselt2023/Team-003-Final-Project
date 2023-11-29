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

  # routes for profile and user management
  get 'profile', to: 'home#profile', as: :profile
  resources :users do
    resources :messages, only: [:create]
    member do
      patch :verify
      patch :unverify
      get :listings, to: 'users#listings', as: 'user_listings'
    end
    collection do
      get :admin
    end
  end

  # routes for products, reviews, and listings
  resources :products do
    member do
      post :add_to_cart
      post :message_seller
      post :write_review
      post :add_to_favorites
    end
    resources :listings
    resources :reviews, only: [:new, :create, :destroy]
    collection do
      get 'search'
    end
  end

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
  get 'trackings/show'
  get 'categories/index'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end

