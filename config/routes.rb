Rails.application.routes.draw do
  get 'trackings/show'
  get 'feedback/new'
  get 'feedback/create'
  get 'search/index'
  get 'categories/index'

  # root route for the marketplace home page
  root 'home#index'

  # routes for session management (login and logout)
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # routes for forgot your password link (password resets)
  resources :password_resets, only: [:new, :create, :edit, :update]

  # route for the registration form
  get 'signup', to: 'registrations#new', as: :new_registration

  resources :reviews, only: [:new,:create]

  # routes for user registration (new and create)
  resources :registrations, only: [:new, :create]

  # routes for orders and cart (purchasing)
  resources :orders, only: [:new, :create, :show]
  resources :cart_items, only: [:create, :update, :destroy] do
    member do
      patch :increase
      patch :decrease
    end
  end

  # route for if the cart has a show action to display an individual user's cart
  resource :cart, only: [:show]

  resources :orders, only: [:new, :create, :show] do
    resources :feedback, only: [:new, :create]
    resource :tracking, only: [:show]
  end

  # routes for messages
  resources :conversations, only: [:index, :show] do
    resources :messages, only: [:new, :create]
  end

  # list all messages separately, you can also include:
  resources :messages, only: [:index]
  
  # routes for categories
  resources :categories, only: [:index, :show]

  # routes for search action
  get 'search', to: 'search#index', as: 'search'

  # routes for listings
  resources :listings

  resources :favorites, only: [:index, :create, :destroy]

  resources :products do
    # existing member routes
    member do
      post 'add_to_cart'
      get :message_seller
      post 'write_review'
      post 'add_to_favorites'
    end

    # routes for reviews
    resources :reviews, only: [:new, :create, :destroy]

    # collection route for searching products
    collection do
      get 'search' # route to a search action in ProductsController
    end
  end
  # route for if the cart has a show action to display an individual user's cart
  resource :cart, only: [:show]

  # routes for creating cart items
  resources :cart_items, only: [:create, :update, :destroy]

  # routes for navigation
  get 'profile', to: 'home#profile', as: :profile
  post 'message', to: 'home#profile'

  resources :users do
    collection do
      get :admin
    end
    member do
      patch :verify
      patch :unverify
    end
  end

  # health check route
  get "up" => "rails/health#show", as: :rails_health_check

end

