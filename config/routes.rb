Rails.application.routes.draw do
  get 'search/index'
  get 'categories/index'

  # root route for the marketplace home page
  root 'welcome#index'

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

  # routes for orders (purchasing)
  resources :orders, only: [:new, :create]

  # routes for categories
  resources :categories, only: [:index]

  # routes for search action
  get 'search', to: 'search#index', as: 'search'

  # routes for listings
  resources :listings

  # routes for product details
  resources :products do
    member do
      post 'add_to_cart'
      post 'message_seller'
      post 'write_review'
    end
    resources :reviews, only: [:create, :destroy]
  end

  # route for if the cart has a show action to display an individual user's cart
  resource :cart, only: [:show]

  # routes for creating cart items
  resources :cart_items, only: [:create, :update, :destroy]

  # health check route
  get "up" => "rails/health#show", as: :rails_health_check

end

