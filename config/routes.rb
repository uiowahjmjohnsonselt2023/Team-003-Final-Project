Rails.application.routes.draw do
  get 'tracking/show'
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
    get 'tracking/show', to: 'tracking#show', as: :tracking_show
  end

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
    resources :reviews, only: [:new, :create, :destroy]
  end


  # health check route
  get "up" => "rails/health#show", as: :rails_health_check

end

